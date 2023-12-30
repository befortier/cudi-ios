//
//  PetItem.swift
//  ios-cudi
//
//  Created by Ben Fortier on 12/29/23.
//

import Foundation
import SwiftUI

@MainActor
struct PetItem: View {
    let pet: Pet

    var body: some View {
        VStack(alignment: .center, spacing: 8) {
            petAvatarView
                .frame(width: 56, height: 56)
            Text(pet.name)
                .font(.headline)
        }
        .frame(width: 100, height: 120) // Adjust frame width as needed
        .background(Color.white)
        .foregroundStyle(AppColor.textPrimary)
        .cornerRadius(15)
        .shadow(color: Color.gray.opacity(0.2), radius: 5, x: 0, y: 3)
    }

    @ViewBuilder
    private var petAvatarView: some View {
        if let avatarURL = pet.avatarURL {
            CircleImageView(imageURL: avatarURL)
        } else {
            CircleImageView(systemName: "pawprint.fill")
        }
    }
}

#Preview {
    PetItem(pet: Pet(petDTO: .cudi))
        .padding()
        .background(AppColor.softBackground)
}
