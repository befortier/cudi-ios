//
//  PetStore+Stub.swift
//  ios-cudi
//
//  Created by Ben Fortier on 12/29/23.
//

import Foundation

@MainActor
extension PetStore {
    static var stub: PetStore {
        let petDTOs = [
            PetDTO.cudi,
            PetDTO(id: "ranom", name: "Brisco", type: .dog, birthdate: .now, avatarURL: nil),
            PetDTO(id: "ranom2", name: "Catto", type: .cat, birthdate: .now, avatarURL: nil),
        ]
        return PetStore(
            modelContext: try! .init(.init(for: Pet.self, configurations: .init(isStoredInMemoryOnly: true))),
            user: .stub,
            pets: petDTOs.map { Pet(petDTO: $0) }
        )
    }
}
