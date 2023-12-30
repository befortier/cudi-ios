//
//  Endpoint.swift
//  ios-cudi
//
//  Created by Ben Fortier on 12/27/23.
//

import Foundation

protocol Endpoint: Sendable {
    var baseURL: String { get }
    var path: String { get }
    var queryParameters: [String: String]? { get }
    var headers: [String: String]? { get }
}

extension Endpoint {
    var baseURL: String { "localhost" }
    
    var urlString: String? {
        guard var urlComponents = URLComponents(string: baseURL) else { return nil }
        urlComponents.path += path

        if
            let queryParameters = queryParameters {
            urlComponents.queryItems = queryParameters.map { URLQueryItem(name: $0.key, value: $0.value) }
        }

        // Ensure proper URL encoding for each component
        let encodedPath = urlComponents.path.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed) ?? urlComponents.path
        let encodedQuery = urlComponents.query?.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? urlComponents.query

        // Combine encoded components for a valid URL string
        return encodedPath + (encodedQuery ?? "")
    }
}
