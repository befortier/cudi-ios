//
//  InterpretedHTTPMethod.swift
//  ios-cudi
//
//  Created by Ben Fortier on 12/30/23.
//

import Foundation

enum InterpretedHTTPMethod {
    case get
    case post(Data?)
    case delete
}
