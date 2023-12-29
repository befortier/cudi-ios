//
//  BaseTextField+ViewModel.swift
//  ios-cudi
//
//  Created by Ben Fortier on 12/27/23.
//

import Foundation
import Foundation
import SwiftUI

@MainActor
final class BaseTextFieldViewModel: ObservableObject {
    struct TextFieldConfig: Equatable, Sendable {
        /// The alignment of the label
        let labelAlignment: Alignment

        /// The alignment of the text field
        let textFieldAlignment: Alignment

        /// The font of the label
        let labelFont: Font

        /// The vertical offset for the label and textfield
        let verticalOffset: CGFloat

        /// The config for the empty state
        static let empty = TextFieldConfig(
            labelAlignment: .leading,
            textFieldAlignment: .leading,
            labelFont: .body,
            verticalOffset: 0
        )

        /// The config for the populated state
        static let populated = TextFieldConfig(
            labelAlignment: .topLeading,
            textFieldAlignment: .bottomLeading,
            labelFont: .caption,
            verticalOffset: 6
        )
    }

    /// The configuration for the view
    @Published var textFieldConfig: TextFieldConfig

    /// The border color of the text field
    @Published var borderColor: Color = .gray

    /// The error message text
    @Published var errorMessageText: String?

    let errorColor: Color

    init(text: String, errorColor: Color) {
        self.textFieldConfig = Self.config(from: text)
        self.errorColor = errorColor
    }

    /// Updates state based on the `errorMessage` passed
    func errorMessageDidChange(_ errorMessage: String?) {
        let hasError = !(errorMessage ?? "").isEmpty
        self.borderColor = hasError ? errorColor : .gray
        self.errorMessageText = hasError ? errorMessage : nil
    }

    /// Updates state based on the `text` passed
    func textDidChange(_ text: String) {
        self.textFieldConfig = Self.config(from: text)
    }

    // MARK: State Calculation

    private static func config(from text: String) -> TextFieldConfig {
        return text.isEmpty ? .empty : .populated
    }
}
