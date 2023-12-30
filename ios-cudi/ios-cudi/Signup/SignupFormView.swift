//
//  FormView.swift
//  ios-cudi
//
//  Created by Ben Fortier on 12/28/23.
//

import Foundation
import SwiftUI

enum FormStatus: Equatable, Sendable {
    case idle
    case invalidSubmission
    case validSubmission(CreateUserDTO)
}

@MainActor
struct SignupFormView: View {
    var form: SignupForm
    @Binding var formStatus: FormStatus
    @State var errorMessage: String?

    var body: some View {
        VStack(spacing: 24) {
            NameTextField(textFieldState: form.nameState)

            EmailTextField(textFieldState: form.emailState)
                .onChange(of: form.emailState.error) { _, newError in
                    errorMessage = newError?.localizedDescription
                }

            PasswordTextField(textFieldState: form.passwordState)

            CudiRelationshipPickerView(
                cudiRelationship: Binding<CudiRelationship>(
                    get: { form.cudiRelationship },
                    set: { form.cudiRelationship = $0 }
                )
            )
            .padding(.bottom, 24)
            favoriteCudiPartView
                .padding(.horizontal, 16)
            Spacer()

            errorMesssage
            submitButton
        }
    }

    private var favoriteCudiPartView: some View {
        TextField(
            "What's your favorite thing about Cudi?",
            text: Binding<String>(
                get: { form.favoriteCudiThing },
                set: { form.favoriteCudiThing = $0 }
            ),
            axis: .vertical
        )
        .lineLimit(5...10)
        .fixedSize(horizontal: false, vertical: true)
        .multilineTextAlignment(.leading)
    }


    @ViewBuilder
    private var errorMesssage: some View {
        if let errorMessage {
            (Text(Image(systemName: "lock")) + Text(errorMessage))
                .foregroundColor(.red)
                .font(.title3)
        }
    }

    private var submitButton: some View {
        Button {
            self.formStatus = form.attemptSubmission()
        } label: {
            Text("Join the Pack!")
                .font(.headline)
                .foregroundColor(.white)
                .padding()
                .background(Color.purple)
                .cornerRadius(10)
        }
    }
}
