//
//  ValidationError.swift
//  ios-cudi
//
//  Created by Ben Fortier on 12/28/23.
//

import Foundation

enum ValidationError: LocalizedError, Equatable {
    case invalidEmail
    case invalidPassword
    case general

    var errorDescription: String? {
        switch self {
        case .invalidEmail:
            NSLocalizedString("The email was invalid", comment: "Invalid email")
        case .invalidPassword:
            NSLocalizedString("The password was invalid", comment: "Invalid password")
        case .general:
            NSLocalizedString("The field was invalid", comment: "Invalid field")

        }
    }
}
