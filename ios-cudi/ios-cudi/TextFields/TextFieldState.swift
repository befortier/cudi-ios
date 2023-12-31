//
//  TextFieldState.swift
//  ios-cudi
//
//  Created by Ben Fortier on 12/28/23.
//

import Foundation
import SwiftUI

@MainActor @Observable
public final class TextFieldState<ResultType> {

    private let validator: any TextFieldValidator<ResultType>
    var text: String
    var error: ValidationError?

    var isValid: Bool { error == nil }

    public init(
        validator: any TextFieldValidator<ResultType>,
        text: String = ""
    ) {
        self.validator = validator
        self.text = text
    }

    func validate() -> ResultType? {
        do {
            let result = try validator.validate(text: text)
            self.error = nil
            return result
        } catch {
            self.error = error as? ValidationError ?? .general
            return nil
        }
    }
}
