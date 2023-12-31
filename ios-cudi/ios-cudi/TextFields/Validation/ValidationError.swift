//
//  ValidationError.swift
//  ios-cudi
//
//  Created by Ben Fortier on 12/28/23.
//

import Foundation

enum ValidationError: LocalizedError, Equatable {
    case invalidEmail

    // MARK: Password
    
    case passwordLengthTooShort
    case requiresOneCapitalAndOneSpecialChar

    case emptyName
    case invalidBirthday
    case general

    var errorDescription: String? {
        switch self {
        case .invalidEmail:
            NSLocalizedString("The email was invalid", comment: "Invalid email")
        case .passwordLengthTooShort:
            NSLocalizedString("The password was too short", comment: "Invalid password")
        case .requiresOneCapitalAndOneSpecialChar:
            NSLocalizedString("The password needs a special char", comment: "Invalid password")
        case .emptyName:
            NSLocalizedString("Name cannot be empty", comment: "Invalid password")
        case .invalidBirthday:
            NSLocalizedString("Birthday must be of MM/DD/YYYY format", comment: "Invalid birthday")
        case .general:
            NSLocalizedString("The field was invalid", comment: "Invalid field")
        }
    }
}
