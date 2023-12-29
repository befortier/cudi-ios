//
//  NameTextField.swift
//  ios-cudi
//
//  Created by Ben Fortier on 12/28/23.
//

import Foundation
import SwiftUI

@MainActor
struct NameTextField: View {
    @Bindable var textFieldState: TextFieldState

    var body: some View {
        BaseTextField(
            "Name",
            textFieldState: $textFieldState,
            errorColor: .red
        ) {
            Image(systemName: "person")
                .renderingMode(.template)
                .foregroundColor(.gray)

        } onEditingChanged: { @MainActor isEditing in
            if isEditing {
                self.textFieldState.error = nil
            }
        }
        .textContentType(.name)
        .autocapitalization(.words)
        .disableAutocorrection(true)
    }
}
