//
//  FormView.swift
//  ios-cudi
//
//  Created by Ben Fortier on 12/28/23.
//

import Foundation
import SwiftUI

struct CreateUserDTO: Equatable, Sendable, Encodable {
    let userID = UUID().uuidString
    let name: String
    let email: String
    let createdAt: Date = .now
    let password: String
    let cudiRelationship: CudiRelationship
    let favoritePartAboutCudi: String
}

enum FormStatus: Equatable, Sendable {
    case idle
    case invalidSubmission
    case validSubmission(CreateUserDTO)
    case editing
}

@MainActor
struct FormView: View {
    var form: Form
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

extension FormView {
    // TODO: Maybe a Model (with type: .signup) -> store in and refill if we get to the multipage like duo
    @MainActor @Observable
    class Form: Identifiable {
        enum Identifier {
            case signup
        }
        let id: Identifier

        var emailState = TextFieldState(validator: EmailValidator())
        var passwordState = TextFieldState(validator: PasswordValidator())
        var nameState = TextFieldState(validator: PasswordValidator())
        var cudiRelationship: CudiRelationship = .father
        var favoriteCudiThing: String = ""

        init(id: Identifier) {
            self.id = id
        }

        func validate() -> Bool {
            [emailState, passwordState, nameState]
                .allSatisfy {
                    $0.validate()
                    return $0.isValid
                }
        }

        func attemptSubmission() -> FormStatus {
            self.validate() ?
                .validSubmission(
                    CreateUserDTO(
                        name: self.nameState.text,
                        email: self.emailState.text,
                        password: self.passwordState.text,
                        cudiRelationship: self.cudiRelationship,
                        favoritePartAboutCudi: self.favoriteCudiThing
                    )
                ) :
                .invalidSubmission
        }
    }
}
