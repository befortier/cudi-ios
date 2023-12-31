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
    var birthday: Date?
    
    func validate() -> Bool {
        [nameState]
            .allSatisfy {
                $0.validate()
                return $0.isValid
            }
    }

    func attemptSubmission() -> AddPetDTO? {
        guard self.validate() else { return nil }
        return AddPetDTO(name: nameState.text, type: selectedPetType, birthdate: birthday ?? .now, avatar: image?.pngData())
    }
}
