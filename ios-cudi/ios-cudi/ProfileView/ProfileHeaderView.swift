//
//  ProfileHeaderView.swift
//  ios-cudi
//
//  Created by Ben Fortier on 12/29/23.
//

import Foundation
import SwiftUI

struct ProfileHeaderView: View {
    @Environment(\.user) var user: User

    var body: some View {
        VStack(spacing: 16) {
            HStack(spacing: 16) {
                AsyncCachedImage(url: user.avatarURL) {
                    Circle()
                        .fill(.gray)
                        .modifier(ShimmerModifier())
                }
                .frame(width: 70, height: 70)
                .clipShape(Circle())
                .overlay(
                    Circle()
                        .stroke(
                            Color.gray.opacity(0.2),
                            lineWidth: 2
                        )
                )
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
        .padding(.vertical, 32)
        .padding(.bottom, 16)
        .frame(maxWidth: .infinity)
        .background(
            LandingBackgroundView().ignoresSafeArea()
        )
    }
}

#Preview {
    ProfileHeaderView()
        .setUser(.stub)
}
