//
//  ActivityFeedStore.swift
//  ios-cudi
//
//  Created by Ben Fortier on 12/31/23.
//

import Foundation
import SwiftData
import SwiftUI

@MainActor @Observable
class ActivityFeedStore {

    private let activityFeedServiceAPIClient = ActivityFeedServiceAPIClient()
    private let modelContext: ModelContext
    private let user: User

    var items: [ActivityFeedItem]

    init(
        modelContext: ModelContext,
        user: User,
        items: [ActivityFeedItem] = []
    ) {
        self.modelContext = modelContext
        self.user = user
        self.items = items
    }

    func loadActivityFeedHome() async throws {
        let activityFeedDTOs = try await activityFeedServiceAPIClient.getActivityHome()
        let activityFeedItems = activityFeedDTOs.map { ActivityFeedItem(activityFeedDTO: $0) }
        // TODO: Save Home to core data
//
//        // remove any pets that are not in source of truth
//        let noLongerExistingPets = Set(self.pets).subtracting(Set(pets))
//        noLongerExistingPets.forEach { modelContext.delete($0) }
//
//        pets.forEach { modelContext.insert($0) }
//        self.pets = pets

    }

    func removePets() {
        self.items.forEach {
            modelContext.delete($0)
        }
        self.items = []
    }
}
