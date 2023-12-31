//
//  SignupForm.swift
//  ios-cudi
//
//  Created by Ben Fortier on 12/29/23.
//

import Foundation
import UIKit

@MainActor @Observable
class SignupForm: Identifiable {
    var image: UIImage?
    var emailState = TextFieldState(validator: EmailValidator())
    var passwordState = TextFieldState(validator: PasswordValidator())
    var nameState = TextFieldState(validator: NameValidator())
    var cudiRelationship: CudiRelationship = .father
    var favoriteCudiThing: String = ""

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
