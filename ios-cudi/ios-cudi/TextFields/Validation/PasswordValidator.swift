//
//  PasswordValidator.swift
//  ios-cudi
//
//  Created by Ben Fortier on 12/28/23.
//

import Foundation

struct PasswordValidator: TextFieldValidator {
    typealias Password = String
    func validate(text: String) throws -> Password {
        // Minimum length:
        if text.count < 8 {
            throw ValidationError.passwordLengthTooShort
        }

        // Regex patterns for specific character types:
        let uppercaseRegex = ".*[A-Z]+.*"
        let lowercaseRegex = ".*[a-z]+.*"
        let digitRegex = ".*[0-9]+.*"
        let specialCharRegex = ".*[^A-Za-z0-9]+.*"

        // Check for at least one character of each type:
        let isValid = NSPredicate(format: "SELF MATCHES %@", uppercaseRegex).evaluate(with: text) &&
        NSPredicate(format: "SELF MATCHES %@", lowercaseRegex).evaluate(with: text) &&
        NSPredicate(format: "SELF MATCHES %@", digitRegex).evaluate(with: text) &&
        NSPredicate(format: "SELF MATCHES %@", specialCharRegex).evaluate(with: text)

        guard isValid else {
            throw ValidationError.requiresOneCapitalAndOneSpecialChar
        }
        return text
    }
}
