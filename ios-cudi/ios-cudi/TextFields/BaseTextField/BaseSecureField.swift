//
//  BaseSecureField.swift
//  ios-cudi
//
//  Created by Ben Fortier on 12/27/23.
//

import Foundation
import SwiftUI

public struct BaseSecureField<ResultType>: View {
    public typealias TextState = TextFieldState<ResultType>
    private let title: any StringProtocol

    /// If true masks the text to secure field
    @State private var maskText: Bool = true
    @Bindable private var textFieldState: TextState

    private var imagePath: String {
        maskText ? "eye.fill" : "eye.slash.fill"
    }

    public init<Title: StringProtocol>(
        _ title: Title,
        textFieldState: Bindable<TextState>
    ) {
        self.title = title
        self._textFieldState = textFieldState
    }

    public var body: some View {
        BaseTextField(
            title,
            textFieldState: $textFieldState,
            accessoryItem: { accessoryItem }
        )
        .maskText(maskText)
    }

    /// An image that handles hiding/showing password characters
    private var accessoryItem: some View {
        Button {
            maskText.toggle()
        } label: {
            Image(systemName: imagePath)
                .renderingMode(.template)
                .foregroundColor(.gray)
                .animation(nil, value: imagePath)
        }
    }
}

// MARK: - Previews

#Preview {
    let validTextFieldState = TextFieldState(validator: PasswordValidator(), text: "b@f.com")
    let errorTextFieldState = TextFieldState(validator: PasswordValidator(), text: "fake")
    let emptyTextFieldState = TextFieldState(validator: PasswordValidator(), text: "")

    return VStack {
        BaseSecureField("Password", textFieldState: .init(wrappedValue: validTextFieldState))
        BaseSecureField("Password", textFieldState: .init(wrappedValue: emptyTextFieldState))
        BaseSecureField("Password", textFieldState: .init(wrappedValue: errorTextFieldState))
    }
    .padding()
}
