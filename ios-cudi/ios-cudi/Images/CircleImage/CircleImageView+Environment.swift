//
//  CircleImageView+Environment.swift
//  ios-cudi
//
//  Created by Ben Fortier on 12/30/23.
//

import Foundation
import SwiftUI

// MARK: CircleCardSize

@MainActor
private struct CircleCardSizeEnvironmentKey: EnvironmentKey {
    static let defaultValue = CircleCardSize.medium
}

extension EnvironmentValues {
    var circleCardSize: CircleCardSize {
        get { self[CircleCardSizeEnvironmentKey.self] }
        set { self[CircleCardSizeEnvironmentKey.self] = newValue }
    }
}

extension View {
    func setCircleCardSize(_ circleCardSize: CircleCardSize) -> some View {
        environment(\.circleCardSize, circleCardSize)
    }
}

