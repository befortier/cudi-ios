//
//  NameValidator.swift
//  ios-cudi
//
//  Created by Ben Fortier on 12/31/23.
//

import Foundation

struct NameValidator: TextFieldValidator {
    func validate(text: String) throws {
        guard !text.isEmpty else { throw ValidationError.emptyName }
    }
}
