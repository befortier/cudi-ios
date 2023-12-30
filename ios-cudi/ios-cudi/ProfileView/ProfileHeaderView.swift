//
//  ProfileHeaderView.swift
//  ios-cudi
//
//  Created by Ben Fortier on 12/29/23.
//

import Foundation
import SwiftUI

@MainActor
struct ProfileHeaderView: View {
    @Environment(\.user) var user: User
    @State var selectedImage: UIImage?

    var body: some View {
        VStack(spacing: 16) {
            HStack(spacing: 16) {
                EditableAvatarView(
                    selectedImage: $selectedImage,
                    url: user.avatarURL
                )
                .setCircleCardSize(.medium)

                VStack(alignment: .leading, spacing: 4) {
                    Text(user.name)
                        .font(.title2)
                        .bold()
                    Text(user.favoritePartAboutCudi)
                        .font(.caption)
                        .lineLimit(2)
                        .foregroundColor(.gray)
                }
            }
        }
    }
}

#Preview {
    let container = previewModelContainer
    return ProfileHeaderView()
        .modelContainer(container)
}
