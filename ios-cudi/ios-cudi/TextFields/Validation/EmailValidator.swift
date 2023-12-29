//
//  EmailValidator.swift
//  ios-cudi
//
//  Created by Ben Fortier on 12/28/23.
//

import Foundation


struct EmailValidator: TextFieldValidator {
    func validate(text: String) throws {
        
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        guard NSPredicate(format: "SELF MATCHES %@", emailRegex).evaluate(with: text) else {
            throw ValidationError.invalidEmail
        }
    }
}
