//
//  MinimalistNavBar+ViewModifier.swift
//  ios-cudi
//
//  Created by Ben Fortier on 12/31/23.
//

import Foundation
import SwiftUI

struct MinimalistNavBarViewModifier: ViewModifier {
    @Environment(\.dismiss) var dismiss

    func body(
        content: Content
    ) -> some View {
        content
            .navigationBarBackButtonHidden(true)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button(action: {
                        dismiss()
                    }) {
                        Image(systemName: "arrow.left")
                            .tint(.primary)
                    }
                }
            }
    }
}


extension View {
    func minamlistNavBar() -> some View {
        modifier(MinimalistNavBarViewModifier())
    }
}
