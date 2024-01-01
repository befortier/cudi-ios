//
//  CircularPetCard.swift
//  ios-cudi
//
//  Created by Ben Fortier on 1/1/24.
//

import Foundation
import SwiftUI

@MainActor
struct CircularPetCard: View {
    private let aspectRatio: CGFloat = 0.85
    @Environment(\.petCardSize) private var  petCardSize

    private let pet: Pet
    private let imageContentType: ImageContentType

    init(pet: Pet) {
        self.pet = pet
        if let avatarURL = pet.avatarURL {
            self.imageContentType = .remote(avatarURL)
        } else {
            self.imageContentType = .systemName(pet.type.rawValue)
        }
    }

    var body: some View {
        VStack(alignment: .center, spacing: 4) {
            CircleImageView(contentType: imageContentType)
                .setCircleCardSize(petCardSize.circleCardSize)
            titleView
        }
        .foregroundStyle(AppColor.textPrimary)
    }

    private var titleView: some View {
        Text(pet.name)
            .font(petCardSize.font)
            .fontWeight(petCardSize.fontWeight)
            .foregroundStyle(AppColor.textPrimary)
            .padding(.vertical, 4)
    }
}

#Preview {
    let container = DataController.previewContainer
    let cudi = Pet(petDTO: .cudi)
    let url = URL(string: "gogole.com")!
    cudi.avatarURL = url
    return HStack(spacing: 8) {
        CircularPetCard(pet: cudi)
            .setPetCardSize(.small)
        CircularPetCard(pet: cudi)
            .setPetCardSize(.medium)
        CircularPetCard(pet: cudi)
            .setPetCardSize(.large)

    }
    .task {
        await InMemoryCache.shared.set(UIImage(named: "cudi"), for: url)
    }
    .modelContainer(container)
    .padding()
    .background(AppColor.softBackground)
}
