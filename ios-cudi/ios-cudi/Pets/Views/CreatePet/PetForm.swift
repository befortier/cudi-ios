//
//  PetForm.swift
//  ios-cudi
//
//  Created by Ben Fortier on 12/31/23.
//

import Foundation
import SwiftUI


@MainActor @Observable
class PetForm: Identifiable {
    var image: UIImage? = nil
    var nameState = TextFieldState(validator: NameValidator())
    var selectedPetType: PetType = .dog
    var birthdayState = TextFieldState(validator: BirthdayValidator())

    func attemptSubmission() -> AddPetDTO? {
        guard
            let name = nameState.validate(),
            let birthday = birthdayState.validate()
        else {
            return nil
        }

        return AddPetDTO(name: name, type: selectedPetType, birthdate: birthday, avatar: image?.pngData())
    }
}
