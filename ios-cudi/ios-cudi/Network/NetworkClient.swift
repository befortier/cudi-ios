//
//  NetworkClient.swift
//  ios-cudi
//
//  Created by Ben Fortier on 12/27/23.
//

import Foundation

protocol NetworkClient: Sendable {
    func fetch<T: Decodable>(url: URL) async throws -> T
}

struct URLSessionClient: NetworkClient {
    private let session: URLSession

    init(session: URLSession = .shared) {
        self.session = session
    }

    func fetch<T: Decodable>(url: URL) async throws -> T {
        let (data, response) = try await session.data(from: url)

        guard let httpResponse = response as? HTTPURLResponse,
              (200...299).contains(httpResponse.statusCode) else {
            throw NetworkError.invalidResponse
        }

        let decodedResponse = try JSONDecoder().decode(T.self, from: data)
        return decodedResponse
    }
}
