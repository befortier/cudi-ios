//
//  ActivityFeedItemType.swift
//  ios-cudi
//
//  Created by Ben Fortier on 12/31/23.
//

import Foundation

enum ActivityFeedItemType: String, EnumeratedModel {
    case walk
    case food
    case playdate

    var id: String { self.rawValue }
}
