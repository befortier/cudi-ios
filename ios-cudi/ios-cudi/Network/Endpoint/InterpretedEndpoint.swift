//
//  InterpretedEndpoint.swift
//  ios-cudi
//
//  Created by Ben Fortier on 12/31/23.
//

import Foundation

struct InterpretedEndpoint {
    let method: InterpretedHTTPMethod
    let url: URL
    let headers: [String: String]
}
