//
//  PasswordTextField.swift
//  ios-cudi
//
//  Created by Ben Fortier on 12/28/23.
//

import Foundation
import SwiftUI

@MainActor
struct PasswordTextField: View {
    @Bindable var textFieldState: TextFieldState<String>

    var body: some View {
        BaseSecureField("Password", textFieldState: $textFieldState)
        .autocapitalization(.none)
        .disableAutocorrection(true)
    }
}
