//
//  EndpointInterpreter.swift
//  ios-cudi
//
//  Created by Ben Fortier on 12/31/23.
//

import Foundation

struct EndpointInterpreter<NetworkEndpoint: Endpoint> {
    private let endpoint: NetworkEndpoint

    init(endpoint: NetworkEndpoint) {
        self.endpoint = endpoint
    }

    func interpret() throws -> InterpretedEndpoint {
        let interpretedHTTPMethod: InterpretedHTTPMethod = switch endpoint {
            case let endpoint as any PostEndpoint:
                .post(try requestBody(for: endpoint.requestBody))
            case _ as any GetEndpoint:
                .get
            default:
                .delete
        }

        return InterpretedEndpoint(
            method: interpretedHTTPMethod,
            url: try url(),
            headers: endpoint.headers ?? [:]
        )
    }

    private func requestBody(for requestBody: (any NetworkRequestBody)?) throws -> Data? {
        if let requestBody {
            return try JSONEncoder().encode(requestBody)
        } else {
           return nil
        }
    }

    private func url() throws -> URL {
        guard var urlComponents = URLComponents(string: endpoint.baseURL) else {
            throw NetworkError.invalidURL
        }

        urlComponents.path += endpoint.path

        if
            let queryParameters = endpoint.queryParameters {
            urlComponents.queryItems = queryParameters.map { URLQueryItem(name: $0.key, value: $0.value) }
        }

        // Ensure proper URL encoding for each component
        let encodedPath = urlComponents.path.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed) ?? urlComponents.path
        let encodedQuery = urlComponents.query?.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? urlComponents.query

        // Combine encoded components for a valid URL string
        let urlString = encodedPath + (encodedQuery ?? "")
        guard let url = URL(string: urlString) else {
            throw NetworkError.invalidURL
        }
        return url
    }
}
