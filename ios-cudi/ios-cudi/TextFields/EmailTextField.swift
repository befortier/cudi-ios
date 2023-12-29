//
//  EmailTextField.swift
//  ios-cudi
//
//  Created by Ben Fortier on 12/27/23.
//

import Foundation
import SwiftUI

@MainActor
struct EmailTextField: View {
    @Bindable var textFieldState: TextFieldState

    var body: some View {
        BaseTextField(
            "Email",
            textFieldState: $textFieldState,
            errorColor: .red
        ) {
            Image(systemName: "envelope")
                .renderingMode(.template)
                .foregroundColor(.gray)

        } onEditingChanged: { @MainActor isEditing in
            if isEditing {
                self.textFieldState.error = nil
            }
        }
        .keyboardType(.emailAddress)
        .autocapitalization(.none)
        .disableAutocorrection(true)
    }
}
