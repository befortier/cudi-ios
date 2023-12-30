//
//  AppState.swift
//  ios-cudi
//
//  Created by Ben Fortier on 12/29/23.
//

import Foundation
import SwiftData

@MainActor
struct AppState {
    let user: User
    let petStore: PetStore

    init(
        user: User,
        petStore: PetStore
    ) {
        self.user = user
        self.petStore = petStore
    }

    init(
        modelContext: ModelContext,
        user: User
    ) {
        self.user = user
        self.petStore = PetStore(
            modelContext: modelContext,
            user: user
        )
    }
}

@MainActor
extension AppState {
    static func stub(
        user: User? = nil,
        petStore: PetStore? = nil
    ) -> AppState {
        AppState(
            user: user ?? .stub,
            petStore: petStore ?? .stub
        )
    }
}
