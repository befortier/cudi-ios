//
//  ActivityFeedItemType.swift
//  ios-cudi
//
//  Created by Ben Fortier on 12/31/23.
//

import Foundation

enum ActivityFeedItemType: Codable, Equatable, CaseIterable, Identifiable {
    enum FoodType: String, EnumeratedModel {
        case breakfast
        case lunch
        case dinner
        case snack
        case treat

        var title: String {
            self.rawValue.capitalizingFirstLetter()
        }

        var id: String { self.rawValue }
    }

    case walk
    case food(FoodType)
    case pupParty

    var rawValue: String {
        switch self {
        case .walk: "walk"
        case .food(let foodType): foodType.rawValue
        case .pupParty: "pupParty"
        }
    }

    var id: String { self.rawValue }

    static var allCases: [ActivityFeedItemType] {
        [.walk] + FoodType.allCases.map { .food($0) } + [.pupParty]
    }
}
