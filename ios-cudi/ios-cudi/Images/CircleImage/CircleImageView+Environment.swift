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

// MARK: AspectRatio

@MainActor
private struct CircleImageContentModeEnvironmentKey: EnvironmentKey {
    static let defaultValue: ContentMode? = nil
}

extension EnvironmentValues {
    var imageContentMode: ContentMode? {
        get { self[CircleImageContentModeEnvironmentKey.self] }
        set { self[CircleImageContentModeEnvironmentKey.self] = newValue }
    }
}

extension View {
    func setImageContentMode(contentMode: ContentMode) -> some View {
        environment(\.imageContentMode, contentMode)
    }
}
