//
//  BirthdayTextField.swift
//  ios-cudi
//
//  Created by Ben Fortier on 12/31/23.
//

import Foundation
import SwiftUI

@MainActor
struct BirthdayTextField: View {
    @Bindable var textFieldState: TextFieldState<Date>

    var body: some View {
        BaseTextField(
            "Birthday (MM/DD/YY)",
            textFieldState: $textFieldState,
            errorColor: .red
        ) {
            Image(systemName: "birthday.cake")
                .renderingMode(.template)
                .foregroundColor(.gray)

        } onEditingChanged: { @MainActor isEditing in
            if isEditing {
                self.textFieldState.error = nil
            }
        }
        .keyboardType(.numberPad)
        .onChange(of: textFieldState.text) { oldValue, newValue in
            let formattedText = sanitizedBirthdayText(text: newValue)

              // If formatting was successful, update the text field
              if formattedText != newValue {
                  textFieldState.text = formattedText
              }
        }
    }

    func sanitizedBirthdayText(text: String) -> String {

        // Remove any non-digit characters from the text
        let sanitizedText = text.components(separatedBy: CharacterSet.decimalDigits.inverted).joined()

        // Create an empty formatted birthday string
        var formattedBirthday = ""

        // Iterate through the characters of the sanitized text
        for (index, character) in sanitizedText.enumerated().prefix(8) {
            // Insert "/" at the appropriate positions
            if index == 2 || index == 4 {
                formattedBirthday.append("/")
            }

            // Add the character to the formatted string
            formattedBirthday.append(character)
        }

        return formattedBirthday
    }
}

#Preview {
    @State var textFieldState: TextFieldState = .init(validator: BirthdayValidator())

    return BirthdayTextField(textFieldState: textFieldState)
        .padding()
}
