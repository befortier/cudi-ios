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
    private let imageContentType: ImageContentType

    init(pet: Pet) {
        self.pet = pet
        if let avatarURL = pet.avatarURL {
            self.imageContentType = .remote(avatarURL)
        } else {
            self.imageContentType = .systemName("pawprint")
        }
    }

    init() {
        self.pet = nil
        self.imageContentType = .systemName("plus")
    }

    var body: some View {
        VStack(alignment: .center, spacing: 8) {
            CircleImageView(contentType: imageContentType)
                .setCircleCardSize(.medium)
                .background(Color.white)
                .clipShape(Circle())
                .shadow(color: Color.gray.opacity(0.2), radius: 5, x: 0, y: 3)

            Text(title)
                .font(.headline)
        }
        .foregroundStyle(AppColor.textPrimary)
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
