//
//  ActivityFeedTagBadge.swift
//  ios-cudi
//
//  Created by Ben Fortier on 1/1/24.
//

import Foundation
import SwiftUI

@MainActor
struct ActivityFeedTagBadge: View {
    let tag: ActivityFeedTag

    var body: some View {
        switch tag {
        case .itemType(let itemType):
            systemBadge(
                systemName: itemType.systemName,
                backgroundColor: itemType.backgroundColor
            )
        case .descriptor(let descriptor):
            systemBadge(
                systemName: descriptor.systemName,
                backgroundColor: descriptor.backgroundColor
            )
        case .custom(let string):
            Text(string)
                .font(.body)
                .fontWeight(.medium)
                .frame(height: 24)
                .padding(4)
                .background {
                    RoundedRectangle(cornerRadius: 4)
                        .fill(.pink)
                }
        }
    }

    private func systemBadge(
        systemName: String,
        backgroundColor: Color
    ) -> some View {
        Image(systemName: systemName)
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

enum ActivityFeedTag {
    case itemType(ActivityFeedItemType)
    case descriptor(ActivityFeedTagDescriptor)
    case custom(String)
}

enum ActivityFeedTagDescriptor: String, EnumeratedModel {
    case goodBoy
    case goodGirl

    var id: String { self.rawValue }
}

extension ActivityFeedTagDescriptor {
    var systemName: String {
        switch self {
        case .goodBoy: "hand.thumbsup.fill"
        case .goodGirl: "hand.thumbsup.fill"
        }
    }

    var backgroundColor: Color {
        .yellow
    }
}

extension ActivityFeedItemType {
    var systemName: String {
        switch self {
        case .walk: "figure.run"
        case .food(let foodType):
            switch foodType {
            case .breakfast: "sunrise.fill"
            case .lunch: "sun.max.fill"
            case .dinner: "sunset.fill"
            case .snack: "sunset.fill"
            case .treat: "sunset.fill"
            }
        case .pupParty: "person.3.fill"
        }
    }

    var backgroundColor: Color {
        switch self {
        case .walk: .backgroundAlt
        case .food: .background
        case .pupParty: .green
        }
    }
}

#Preview {
    VStack {
        HStack {
            ForEach(ActivityFeedItemType.allCases) { tag in
                ActivityFeedTagBadge(tag:  .itemType(tag))
            }
        }

        HStack {
            ActivityFeedTagBadge(tag:  .custom("Happy pup"))
            ActivityFeedTagBadge(tag:  .custom("Good girl"))
        }
        HStack {
            ForEach(ActivityFeedTagDescriptor.allCases) { tag in
                ActivityFeedTagBadge(tag:  .descriptor(tag))
            }
        }

    }

}
