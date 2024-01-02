//
//  Image+Environment.swift
//  ios-cudi
//
//  Created by Ben Fortier on 1/1/24.
//

import Foundation
import SwiftUI

// MARK: ContentMode

@MainActor
private struct ImageContentModeEnvironmentKey: EnvironmentKey {
    static let defaultValue: ContentMode? = nil
}

extension EnvironmentValues {
    var imageContentMode: ContentMode? {
        get { self[ImageContentModeEnvironmentKey.self] }
        set { self[ImageContentModeEnvironmentKey.self] = newValue }
    }
}

extension View {
    func setImageContentMode(contentMode: ContentMode) -> some View {
        environment(\.imageContentMode, contentMode)
    }
}
