//
//  ActivityFeedItem.swift
//  ios-cudi
//
//  Created by Ben Fortier on 12/31/23.
//

import Foundation
import SwiftData

@MainActor @Model
class ActivityFeedItem {
    @Attribute(.unique) let id: String
    let ownerID: User.ID
    let images: [ActivityFeedImage]
    let ownerPets: [Pet.ID]
    let type: ActivityFeedItemType
    let title: String
    let subtitle: String
    let createdAt: Date

    init(
        id: String,
        ownerID: User.ID,
        images: [ActivityFeedImage],
        ownerPets: [Pet.ID],
        type: ActivityFeedItemType,
        title: String,
        subtitle: String,
        createdAt: Date
    ) {
        self.id = id
        self.ownerID = ownerID
        self.images = images
        self.ownerPets = ownerPets
        self.type = type
        self.title = title
        self.subtitle = subtitle
        self.createdAt = createdAt
    }

    convenience init(activityFeedDTO: ActivityFeedItemDTO) {
        self.init(
            id: activityFeedDTO.id,
            ownerID: activityFeedDTO.ownerID,
            images: activityFeedDTO.images,
            ownerPets: activityFeedDTO.ownerPets,
            type: activityFeedDTO.type,
            title: activityFeedDTO.title,
            subtitle: activityFeedDTO.subtitle,
            createdAt: activityFeedDTO.createdAt
        )
    }
}
