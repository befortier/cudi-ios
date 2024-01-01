//
//  PetStore.swift
//  ios-cudi
//
//  Created by Ben Fortier on 12/29/23.
//

import Foundation
import SwiftData
import SwiftUI

@MainActor @Observable
class PetStore {

    private var petRefreshTask: Task<[PetDTO], any Error>?
    private let petServiceAPIClient = PetServiceAPIClient()
    private let modelContext: ModelContext
    private let user: User

    var pets: [Pet]

    init(
        modelContext: ModelContext,
        user: User,
        pets: [Pet]? = nil
    ) {
        self.modelContext = modelContext
        self.user = user
        let cachedPets = try? modelContext.fetch(FetchDescriptor<Pet>())
        self.pets = pets ?? cachedPets ?? []
    }

    func setPets(_ pets: [Pet]) {
        // remove any pets that are not in source of truth
        let noLongerExistingPets = Set(self.pets).subtracting(Set(pets))
        noLongerExistingPets.forEach { modelContext.delete($0) }

        pets.forEach { modelContext.insert($0) }
        self.pets = pets
    }

    func addPet(petDTO: PetDTO) async throws {
        let pet = Pet(petDTO: petDTO)
        pets.append(pet)
        modelContext.insert(pet)
    }

    func removeAllPets() {
        self.pets.forEach {
            modelContext.delete($0)
        }
        self.pets = []
    }

    func removePet(pet: Pet) {
        modelContext.delete(pet)
        self.pets = self.pets.filter { $0 != pet }
    }

    func removePets(pets: [Pet]) {
        pets.forEach { removePet(pet: $0) }
    }
}
