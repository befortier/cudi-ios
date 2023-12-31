//
//  BaseTextField.swift
//  ios-cudi
//
//  Created by Ben Fortier on 12/27/23.
//

import Foundation
import Combine
import SwiftUI

@MainActor public struct BaseTextField<AccessoryItem: View, ResultType>: View {
    public typealias TextState = TextFieldState<ResultType>

    private let height: CGFloat = 48

    private let title: any StringProtocol
    @Bindable private var textFieldState: TextState

    private let accessoryItem: () -> AccessoryItem
    private let onEditingChanged: (Bool) -> Void

    @Environment(\.maskText) var maskText: Bool

    @StateObject var viewModel: BaseTextFieldViewModel

    public init<Title: StringProtocol>(
        _ title: Title,
        textFieldState: Bindable<TextState>,
        errorColor: Color = .red,
        @ViewBuilder accessoryItem: @escaping () -> AccessoryItem = { EmptyView() },
        onEditingChanged: @escaping (Bool) -> Void = { _ in }
    ) {
        self.title = title
        self.accessoryItem = accessoryItem
        self.onEditingChanged = onEditingChanged
        self._textFieldState = textFieldState
        self._viewModel = StateObject(wrappedValue: BaseTextFieldViewModel(text: textFieldState.wrappedValue.text, errorColor: errorColor))
    }

    public var body: some View {
        VStack(spacing: 8) {
            HStack {
                ZStack(alignment: .leading) {
                    label
                    textField
                        .padding(.bottom, viewModel.textFieldConfig.verticalOffset)
                        .frame(height: height, alignment: viewModel.textFieldConfig.textFieldAlignment)
                        .font(.body)
                        .onChange(of: textFieldState.text) {  _, newText in
                            viewModel.textDidChange(newText)
                        }
                }
                .frame(height: height)

                Spacer()
                accessoryItem()
            }
            .padding(.horizontal, 16)
            .frame(maxWidth: .infinity)
            .frame(height: height)
            .background(RoundedRectangle(cornerRadius: 8).stroke(viewModel.borderColor, lineWidth: 1))
            .contentShape(Rectangle())
            errorMessageText
        }
        .onChange(of: textFieldState.error) { _, newError in
            viewModel.errorMessageDidChange(newError?.localizedDescription)
        }
        .onAppear {
            viewModel.errorMessageDidChange(textFieldState.error?.localizedDescription)
        }
    }

    @ViewBuilder
    private var textField: some View {
        if maskText {
            SecureField("", text: $textFieldState.text)
        } else {
            TextField("", text: $textFieldState.text, onEditingChanged: onEditingChanged)
        }
    }

    @ViewBuilder
    private var errorMessageText: some View {
        if let errorMessage = viewModel.errorMessageText {
            HStack(spacing: 4) {
                Image(systemName: "exclamationmark.circle")
                Text(errorMessage)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .font(.callout)
            .foregroundColor(viewModel.errorColor)
        }
    }

    private var label: some View {
        Text(title)
            .font(viewModel.textFieldConfig.labelFont)
            .foregroundColor(AppColor.textPrimary)
            .padding(.top, viewModel.textFieldConfig.verticalOffset)
            .frame(height: height, alignment: viewModel.textFieldConfig.labelAlignment)
            .animation(.easeInOut(duration: 0.15), value: viewModel.textFieldConfig.verticalOffset)
    }
}

#Preview {
    let validTextFieldState = TextFieldState(validator: EmailValidator(), text: "b@f.com")
    let errorTextFieldState = TextFieldState(validator: EmailValidator(), text: "fake")
    let emptyTextFieldState = TextFieldState(validator: EmailValidator(), text: "")

    return VStack {
        BaseTextField("Email", textFieldState: .init(wrappedValue: validTextFieldState), accessoryItem: { EmptyView() })
        BaseTextField("Email", textFieldState: .init(wrappedValue: errorTextFieldState), accessoryItem: { EmptyView() })
        BaseTextField("Email", textFieldState: .init(wrappedValue: emptyTextFieldState), accessoryItem: { EmptyView() })

        Button("Validate") {
            [validTextFieldState, errorTextFieldState, emptyTextFieldState].forEach { $0.validate() }
        }
    }
    .padding()
}
