//
//  PetStore.swift
//  ios-cudi
//
//  Created by Ben Fortier on 12/29/23.
//

import Foundation
import SwiftData

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
        // TODO: Load from CoreData here
        self.modelContext = modelContext
        self.user = user
        let cachedPets = try? modelContext.fetch(FetchDescriptor<Pet>())
        self.pets = pets ?? cachedPets ?? []
    }

    func loadPets() async throws {
        guard petRefreshTask == nil else { return }
        let petRefreshTask = Task {
            return try await petServiceAPIClient.getPets()
        }
        self.petRefreshTask = petRefreshTask
        let pets = try await petRefreshTask.value
        self.pets = pets.map { Pet(petDTO: $0) }
        self.pets.forEach { modelContext.insert($0) }
        self.petRefreshTask = nil

        let cachedPets = try? modelContext.fetch(FetchDescriptor<Pet>())
        print("Cached", cachedPets, cachedPets?.map { $0.id })
    }

    func removePets() {
        self.pets.forEach { modelContext.delete($0) }
        self.pets = []
    }
}

struct PetRepository {
    let petStore: PetStore
    
}
