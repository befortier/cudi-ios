//
//  ActivityFeedCard+Environment.swift
//  ios-cudi
//
//  Created by Ben Fortier on 1/1/24.
//

import Foundation
import SwiftUI

// MARK: CircleCardSize

enum ActivityFeedCardSize: CGFloat, Sendable {
    case small = 120
    case medium = 150
    case large = 180
}

@MainActor
private struct ActivityFeedCardSizeEnvironmentKey: EnvironmentKey {
    static let defaultValue = ActivityFeedCardSize.medium
}

extension EnvironmentValues {
    var activityCardSize: ActivityFeedCardSize {
        get { self[ActivityFeedCardSizeEnvironmentKey.self] }
        set { self[ActivityFeedCardSizeEnvironmentKey.self] = newValue }
    }
}

extension View {
    func setActivityCardSize(_ activityCardSize: ActivityFeedCardSize) -> some View {
        environment(\.activityCardSize, activityCardSize)
    }
}
