//
//  BirthdayValidator.swift
//  ios-cudi
//
//  Created by Ben Fortier on 12/31/23.
//

import Foundation

struct BirthdayValidator: TextFieldValidator {
    func validate(text: String) throws -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yyyy"

        guard let date = dateFormatter.date(from: text) else {
            throw ValidationError.invalidBirthday
        }

        return date
    }
}
