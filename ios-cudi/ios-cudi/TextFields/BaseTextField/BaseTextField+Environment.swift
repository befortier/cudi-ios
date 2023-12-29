//
//  BaseTextField+Environment.swift
//  ios-cudi
//
//  Created by Ben Fortier on 12/27/23.
//

import Foundation

import Foundation
import SwiftUI

/// A key for the masking of text in  a ``Fetch_Rewards/FetchTextField``
struct MaskTextKey: EnvironmentKey {
    static var defaultValue: Bool = false
}

extension EnvironmentValues {
    /// Whether to mask text in a``Fetch_Rewards/FetchTextField``.
    var maskText: Bool {
        get { self[MaskTextKey.self] }
        set { self[MaskTextKey.self] = newValue }
    }
}

@MainActor
extension BaseTextField {
    /// Sets the maskText value for a ``Fetch_Rewards/FetchTextField``
    func maskText(_ shouldMask: Bool) -> some View {
        environment(\.maskText, shouldMask)
    }
}
