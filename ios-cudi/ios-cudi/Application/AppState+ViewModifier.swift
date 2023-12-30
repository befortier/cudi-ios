//
//  AppStateViewModifier.swift
//  ios-cudi
//
//  Created by Ben Fortier on 12/29/23.
//

import Foundation
import SwiftUI

private struct AppStateViewModifier: ViewModifier {
    let appState: AppState

    func body(content: Content) -> some View {
        content
            .environment(\.user, appState.user)
            .environment(\.petStore, appState.petStore)
    }
}

extension View {
    func setAppState(_ appState: AppState) -> some View {
        environment(\.user, appState.user)
        .environment(\.petStore, appState.petStore)
    }
}
