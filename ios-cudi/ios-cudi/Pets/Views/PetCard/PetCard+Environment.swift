//
//  PetCard+Environment.swift
//  ios-cudi
//
//  Created by Ben Fortier on 12/31/23.
//

import Foundation
import SwiftUI

// MARK: CircleCardSize

enum PetCardSize: CGFloat, Sendable {
    case small = 120
    case medium = 150
    case large = 180
}

@MainActor
private struct PetCardSizeEnvironmentKey: EnvironmentKey {
    static let defaultValue = PetCardSize.medium
}

extension EnvironmentValues {
    var petCardSize: PetCardSize {
        get { self[PetCardSizeEnvironmentKey.self] }
        set { self[PetCardSizeEnvironmentKey.self] = newValue }
    }
}

extension View {
    func setPetCardSize(_ petCardSize: PetCardSize) -> some View {
        environment(\.petCardSize, petCardSize)
    }
}
