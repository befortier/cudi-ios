//
//  PetStore+Stub.swift
//  ios-cudi
//
//  Created by Ben Fortier on 12/29/23.
//

import Foundation
import SwiftData

@MainActor
extension PetStore {
    static func stub(modelContext: ModelContext) -> PetStore {
        let petDTOs = [
            PetDTO.cudi,
            PetDTO(id: "ranom", name: "Brisco", type: .dog, birthdate: .now, avatarURL: nil),
            PetDTO(id: "ranom2", name: "Catto", type: .cat, birthdate: .now, avatarURL: nil),
        ]
        return PetStore(
            modelContext: modelContext,
            user: .stub,
            pets: petDTOs.map { Pet(petDTO: $0) }
        )
    }
}
