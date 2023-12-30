//
//  DefaultAvatarType.swift
//  ios-cudi
//
//  Created by Ben Fortier on 12/30/23.
//

import Foundation

enum DefaultAvatarType: String, RawRepresentable, Sendable {
    case person
    case dog
    case cat

    init(petType: PetType) {
        switch petType {
        case .dog:
            self = .dog
        case .cat:
            self = .cat
        }
    }
}
