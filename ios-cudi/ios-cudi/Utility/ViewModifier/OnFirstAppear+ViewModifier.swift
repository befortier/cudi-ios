//
//  OnFirstAppear+ViewModifier.swift
//  ios-cudi
//
//  Created by Ben Fortier on 12/28/23.
//

import Foundation
import SwiftUI

private struct FirstAppearViewModifier: ViewModifier {
    let action: () -> Void

    // Use @StateObject to persist the state across view's lifetime
    @State private var isFirstAppear = true

    func body(content: Content) -> some View {
        content
            .onAppear {
                if isFirstAppear {
                    isFirstAppear = false
                    action()
                }
            }
    }
}

extension View {
    func onFirstAppear(action: @escaping () -> Void) -> some View {
        modifier(FirstAppearViewModifier(action: action))
    }
}
