//
//  AvatarDomainType.swift
//  ios-cudi
//
//  Created by Ben Fortier on 12/30/23.
//

import Foundation

enum AvatarDomainType: Sendable, Equatable {
    case person
    case pet(PetType)

    var systemName: String {
        switch self {
        case .person: "person"
        case .pet(let petType): petType.rawValue
        }
    }
}
