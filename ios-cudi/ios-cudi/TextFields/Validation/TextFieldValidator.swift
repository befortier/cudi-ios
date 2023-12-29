//
//  TextFieldValidator.swift
//  ios-cudi
//
//  Created by Ben Fortier on 12/28/23.
//

import Foundation

public protocol TextFieldValidator: Sendable {
    func validate(text: String) throws
}
