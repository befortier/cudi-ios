//
//  PetStore+Environment.swift
//  ios-cudi
//
//  Created by Ben Fortier on 12/29/23.
//

import Foundation
import SwiftUI

@MainActor
private struct PetStoreEnvironmentKey: EnvironmentKey {
    static let defaultValue = PetStore(modelContext: sharedModelContainer.mainContext, user: .stub)
}

extension EnvironmentValues {
  var petStore: PetStore {
    get { self[PetStoreEnvironmentKey.self] }
    set { self[PetStoreEnvironmentKey.self] = newValue }
  }
}


