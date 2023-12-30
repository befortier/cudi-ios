//
//  Shimmer+ViewModifier.swift
//  ios-cudi
//
//  Created by Ben Fortier on 12/29/23.
//

import Foundation
import SwiftUI

struct ShimmerModifier: ViewModifier {
    @State private var start = UnitPoint.topLeading
    @State private var end = UnitPoint.bottomTrailing
    @State private var colors: [Color] = [
        Color.white.opacity(
            0.4
        ),
        Color.white.opacity(
            0.1
        )
    ]

    let duration: Double = 5.0
    let easing: Animation = .easeOut

    func body(
        content: Content
    ) -> some View {
        ZStack {
            content
                .redacted(reason: .placeholder)

            GeometryReader { geo in
                LinearGradient(
                    gradient: Gradient(
                        colors: colors
                    ),
                    startPoint: start,
                    endPoint: end
                )
                .frame(
                    width: geo.size.width,
                    height: geo.size.height
                )
                .mask(
                    content
                )
                .animation(
                    Animation.linear(
                        duration: duration
                    ).repeatForever(
                        autoreverses: false
                    ),
                    value: [start]
                )
                .onAppear {
                    start = UnitPoint.trailing
                    end = UnitPoint.leading
                    colors.shuffle()
                }
            }

        }
    }
}


extension View {
    func shimmer() -> some View {
        modifier(ShimmerModifier())
    }
}
