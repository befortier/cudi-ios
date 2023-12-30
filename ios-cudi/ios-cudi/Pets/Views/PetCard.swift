//
//  PetCard.swift
//  ios-cudi
//
//  Created by Ben Fortier on 12/29/23.
//

import Foundation
import SwiftUI

@MainActor
struct PetCard: View {
    private let avatarSize: CGFloat = 75
    private let pet: Pet?
    var title: String {
        pet?.name ?? "Add Pet"
    }

    init(pet: Pet) {
        self.pet = pet
    }

    init() {
        self.pet = nil
    }

    var body: some View {
        VStack(alignment: .center, spacing: 8) {
            avatarIconView
                .setCircleCardSize(.medium)
                .background(Color.white)
                .clipShape(Circle())
                .shadow(color: Color.gray.opacity(0.2), radius: 5, x: 0, y: 3)

            Text(title)
                .font(.headline)
        }
        .foregroundStyle(AppColor.textPrimary)
    }

    @ViewBuilder
    private var avatarIconView: some View {
        if let pet {
            if let avatarURL = pet.avatarURL {
                CircleImageView(imageURL: avatarURL)
            } else {
                CircleImageView(systemName: "pawprint")
            }
        } else {
            CircleImageView(systemName: "plus")
        }

    }
}

#Preview {
    let container = previewModelContainer
    return HStack {
        PetCard(pet: Pet(petDTO: .cudi))
        PetCard()
    }
    .modelContainer(container)
    .padding()
    .background(AppColor.softBackground)
}
