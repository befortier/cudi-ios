//
//  PostEndpoint.swift
//  ios-cudi
//
//  Created by Ben Fortier on 12/30/23.
//

import Foundation

protocol PostEndpoint: Endpoint {
    associatedtype RequestBody: NetworkRequestBody
    var requestBody: RequestBody? { get }
}
