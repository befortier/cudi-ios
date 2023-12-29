//
//  TextFieldState.swift
//  ios-cudi
//
//  Created by Ben Fortier on 12/28/23.
//

import Foundation
import SwiftUI

@MainActor @Observable
public final class TextFieldState {

    private let validator: any TextFieldValidator
    var text: String
    var error: ValidationError?

    var isValid: Bool { error == nil }

    public init(
        validator: any TextFieldValidator,
        text: String = ""
    ) {
        self.validator = validator
        self.text = text
    }

    func validate() {
        do {
            try validator.validate(text: text)
            self.error = nil
        } catch {
            self.error = error as? ValidationError ?? .general
        }
    }
}
