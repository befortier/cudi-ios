//
//  NetworkService.swift
//  ios-cudi
//
//  Created by Ben Fortier on 12/27/23.
//

import Foundation

protocol NetworkService: Sendable {
    func fetchData(from endpoint: Endpoint) async throws -> Data
    func fetch<T: Decodable>(from endpoint: Endpoint) async throws -> T
}

struct NetworkServiceImpl: NetworkService {
    private let client: NetworkClient

    init(client: NetworkClient = URLSessionClient()) {
        self.client = client
    }

    func fetchData(from endpoint: Endpoint) async throws -> Data {
        guard 
            let urlString = endpoint.urlString,
            let url = URL(string: urlString)
        else {
            throw NetworkError.invalidURL
        }
        return try await client.fetch(url: url)
    }

    func fetch<T: Decodable>(from endpoint: Endpoint) async throws -> T {
        let data = try await fetchData(from: endpoint)
        return try JSONDecoder().decode(T.self, from: data)
    }
}
