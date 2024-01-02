//
//  ActivityFeedItemDTO.swift
//  ios-cudi
//
//  Created by Ben Fortier on 12/31/23.
//

import Foundation

struct ActivityFeedItemDTO: DecodedDTO {
    let id: String
    let ownerID: User.ID
    let images: [ActivityFeedImage]
    let ownerPets: [Pet.ID]
    let type: ActivityFeedItemType
    let title: String
    let subtitle: String
    let createdAt: Date
}

struct ActivityFeedImage: Codable, Sendable {
    let url: URL
    let description: String
}


//MARK: Stub

extension ActivityFeedItemDTO {
    static let walk = ActivityFeedItemDTO(
        id: "cudi-walk",
        ownerID: "id",
        images: [.init(url: URL(string: "https://www.helpguide.org/wp-content/uploads/2023/02/Health-Benefits-of-Walks-with-Your-Dog.jpeg")!, description: "Walking")],
        ownerPets: [PetDTO.brisco.id, PetDTO.new.id, "some-ivnalid-id"],
        type: .walk,
        title: "Walk",
        subtitle: "Took cudi for a walk today and he was a good boy. He made lots of friends",
        createdAt: .now
    )

    static let playdate = ActivityFeedItemDTO(
        id: "cudi-walk",
        ownerID: "id",
        images: [.init(url: URL(string: "https://www.helpguide.org/wp-content/uploads/2023/02/Health-Benefits-of-Walks-with-Your-Dog.jpeg")!, description: "Walking")],
        ownerPets: [PetDTO.cudi.id, PetDTO.new.id, PetDTO.brisco.id, PetDTO.gatto.id],
        type: .pupParty,
        title: "Playdate",
        subtitle: "Cudi had a playdate with jeff. They got along great",
        createdAt: .now
    )

    static let food = ActivityFeedItemDTO(
        id: "cudi-walk",
        ownerID: "id",
        images: [.init(url: URL(string: "https://www.helpguide.org/wp-content/uploads/2023/02/Health-Benefits-of-Walks-with-Your-Dog.jpeg")!, description: "Walking")],
        ownerPets: [PetDTO.cudi.id, PetDTO.new.id, "some-ivnalid-id"],
        type: .food(.lunch),
        title: "Lunch",
        subtitle: "Cudi enjoyed his lunch today",
        createdAt: .now
    )
}

