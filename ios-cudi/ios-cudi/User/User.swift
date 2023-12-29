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
    @Relationship(.unique) var id: String
    var name: String
    var email: String
    var createdAt: Date

    var relationshipToCudi: CudiRelationship
    var favoritePartAboutCudi: String

    init(
        id: String,
        name: String,
        email: String,
        createdAt: Date,
        relationshipToCudi: CudiRelationship,
        favoritePartAboutCudi: String
    ) {
        self.id = id
        self.name = name
        self.email = email
        self.createdAt = createdAt
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
