//
//  NetworkService.swift
//  ios-cudi
//
//  Created by Ben Fortier on 12/27/23.
//

import Foundation

protocol NetworkService: Sendable {
    func fetchData<NetworkEndpoint: Endpoint>(
        from endpoint: NetworkEndpoint
    ) async throws -> Data
    
    func fetch<T: Decodable>(from endpoint: any Endpoint) async throws -> T
}

struct NetworkServiceImpl: NetworkService {
    private let client: NetworkClient

    init(client: NetworkClient = URLSessionClient()) {
        self.client = client
    }

    func fetchData<NetworkEndpoint: Endpoint>(
        from endpoint: NetworkEndpoint
    ) async throws -> Data {
        let endpointInterpreter = EndpointInterpreter<NetworkEndpoint>(endpoint: endpoint)
        let interpretedEndpoint = try endpointInterpreter.interpret()
        return try await client.fetch(url: interpretedEndpoint.url)
    }

    func fetch<T: Decodable>(from endpoint: any Endpoint) async throws -> T {
        let data = try await fetchData(from: endpoint)
        return try JSONDecoder().decode(T.self, from: data)
    }
}
