//
//  SignupForm.swift
//  ios-cudi
//
//  Created by Ben Fortier on 12/29/23.
//

import Foundation

@MainActor @Observable
class SignupForm: Identifiable {
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
