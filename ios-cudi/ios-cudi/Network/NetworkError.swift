//
//  NetworkError.swift
//  ios-cudi
//
//  Created by Ben Fortier on 12/27/23.
//

import Foundation

enum NetworkError: Error {
    case invalidURL
    case requestFailed
    case invalidResponse
    case decodingError
    case missingData
}
