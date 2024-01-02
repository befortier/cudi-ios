//
//  ActivityItemTypeIcon.swift
//  ios-cudi
//
//  Created by Ben Fortier on 1/1/24.
//

import Foundation
import SwiftUI

@MainActor struct ActivityItemTypeIcon: View {

    let type: ActivityFeedItemType

    private var imageName: String {
        switch type {
        case .walk:
            "figure.run"
        case .food:
            "fork.knife"
        case .pupParty:
            "person.3.fill"
        }
    }

    private var backgroundColor: Color {
        switch type {
        case .walk: AppColor.backgroundAlt
        case .food: AppColor.background
        case .pupParty: .green
        }
    }

    var body: some View {
        Image(systemName: imageName)
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(width: 24, height: 24)
            .padding(4)
            .background {
                RoundedRectangle(cornerRadius: 4)
                    .fill(backgroundColor)
            }
    }
}
