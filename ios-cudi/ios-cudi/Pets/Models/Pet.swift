//
//  Pet.swift
//  ios-cudi
//
//  Created by Ben Fortier on 12/29/23.
//

import Foundation
import SwiftData

@Model
final class Pet: Identifiable, Equatable {
    @Attribute(.unique) var id: String

    var name: String
    var type: PetType
    var birthdate: Date
    var avatarURL: URL?

    init(
        id: String,
        name: String,
        type: PetType,
        birthdate: Date,
        avatarURL: URL?
    ) {
        self.id = id
        self.name = name
        self.type = type
        self.birthdate = birthdate
        self.avatarURL = avatarURL
    }

    convenience init(petDTO: PetDTO) {
        self.init(
            id: petDTO.id,
            name: petDTO.name,
            type: petDTO.type,
            birthdate: petDTO.birthdate,
            avatarURL: petDTO.avatarURL
        )
    }
}

protocol EnumeratedModel: RawRepresentable, Codable, Equatable, CaseIterable, Identifiable {}

enum PetType: String, EnumeratedModel {
    case dog
    case cat

    var id: String { self.rawValue }
}
