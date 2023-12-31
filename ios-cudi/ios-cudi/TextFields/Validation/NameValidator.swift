//
//  NameValidator.swift
//  ios-cudi
//
//  Created by Ben Fortier on 12/31/23.
//

import Foundation

struct NameValidator: TextFieldValidator {
    typealias Name = String
    func validate(text: String) throws -> Name {
        guard !text.isEmpty else { throw ValidationError.emptyName }
        return text
    }
}
