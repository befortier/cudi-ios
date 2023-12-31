//
//  Endpoint.swift
//  ios-cudi
//
//  Created by Ben Fortier on 12/27/23.
//

import Foundation

protocol Endpoint: Sendable {
    var baseURL: String { get } // TODO: BaseURL moved to service layer
    var path: String { get }
    var queryParameters: [String: String]? { get }
    var headers: [String: String]? { get }
}

typealias NetworkRequestBody = Sendable & Encodable

extension Endpoint {
    var baseURL: String { "localhost" }
}
