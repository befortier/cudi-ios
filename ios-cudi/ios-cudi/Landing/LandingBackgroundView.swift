//
//  LandingBackgroundView.swift
//  ios-cudi
//
//  Created by Ben Fortier on 12/27/23.
//

import Foundation
import SwiftUI

@MainActor
struct LandingBackgroundView: View {
    var body: some View {
        LinearGradient(
            colors: [AppColor.background, AppColor.backgroundAlt],
            startPoint: .topLeading,
            endPoint: .bottomTrailing
        )
    }
}
