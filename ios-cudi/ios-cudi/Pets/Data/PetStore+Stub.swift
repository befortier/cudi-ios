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
            .cudi,
            .brisco,
            .gatto,
            .brodie,
            PetDTO(id: "ranom", name: "Brisco", type: .dog, birthdate: .now, avatarURL: nil),
            PetDTO(id: "ranom2", name: "Catto", type: .cat, birthdate: .now, avatarURL: nil),
        ]
        let pets = petDTOs.map { Pet(petDTO: $0) }
        pets.forEach { modelContext.insert($0) }
        return PetStore(
            modelContext: modelContext,
            user: .stub,
            pets: []
        )
    }
}
