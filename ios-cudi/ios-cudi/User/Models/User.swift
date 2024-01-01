//
//  User.swift
//  ios-cudi
//
//  Created by Ben Fortier on 12/27/23.
//

import Foundation
import SwiftData

@Model
final class User: Identifiable, Equatable {
    @Attribute(.unique) var id: String
    var name: String
    var email: String
    var createdAt: Date
    var avatarURL: URL
    var relationshipToCudi: CudiRelationship
    var favoritePartAboutCudi: String

    init(
        id: String,
        name: String,
        email: String,
        createdAt: Date,
        avatarURL: URL,
        relationshipToCudi: CudiRelationship,
        favoritePartAboutCudi: String
    ) {
        self.id = id
        self.name = name
        self.email = email
        self.createdAt = createdAt
        self.avatarURL = avatarURL
        self.relationshipToCudi = relationshipToCudi
        self.favoritePartAboutCudi = favoritePartAboutCudi
    }
}

extension User {
    static var stub: User {
        User(
            id: "some-id",
            name: "Ben Fortier",
            email: "bennett.fortier@gmail.com",
            createdAt: Date(timeIntervalSince1970: 1703714743),
            avatarURL: defaultAvatarURL,
            relationshipToCudi: .father,
            favoritePartAboutCudi: "Chin"
        )
    }
}


enum CudiRelationship: String, RawRepresentable, Sendable, Codable, CaseIterable, Identifiable {
    case father
    case cousin
    case grammy
    case grampy
    case auntie

    var id: String { self.rawValue }


    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        let rawValue = try container.decode(String.self)

        guard let relationship = CudiRelationship(rawValue: rawValue) else {
            throw DecodingError.dataCorruptedError(in: container, debugDescription: "Invalid CudiRelationship value")
        }

        self = relationship
    }
}

let defaultAvatarURL = URL(string: "https://b3314858.smushcdn.com/3314858/wp-content/uploads/2021/12/Cartoon-Avatar-White-Background.png?lossy=2&strip=1&webp=1")!
