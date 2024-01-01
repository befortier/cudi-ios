//
//  PetRepository.swift
//  ios-cudi
//
//  Created by Ben Fortier on 1/1/24.
//

import Foundation

struct PetRepository {
    private let petServiceAPIClient = PetServiceAPIClient()
    private let petStore: PetStore

    init(
        petStore: PetStore
    ) {
        self.petStore = petStore
    }

    func loadPets() async throws {
        let petDTOs = try await petServiceAPIClient.getPets()
        let pets = petDTOs.map { Pet(petDTO: $0) }
        await petStore.setPets(pets)
    }

    func setPets(with ids: [Pet.ID]) async throws {
        let currentPets = await petStore.pets
        let missingPetIDs = Set(ids).subtracting(Set(currentPets.map { $0.id }))
        let missingPetDTOs = try await petServiceAPIClient.getPets(for: Array(missingPetIDs))
        for petDTO in missingPetDTOs {
            try await petStore.addPet(petDTO: petDTO)
        }
    }

    func addPet(pet: AddPetDTO) async throws {
        let petDTO = try await petServiceAPIClient.addPet(addPetDTO: pet)
        try await petStore.addPet(petDTO: petDTO)
    }
}
