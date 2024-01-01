//
//  RoundedPetCard.swift
//  ios-cudi
//
//  Created by Ben Fortier on 1/1/24.
//

import Foundation
import SwiftUI

@MainActor
struct RoundedPetCard: View {
    private let cornerRadius: CGFloat = 12
    private let aspectRatio: CGFloat = 0.6
    @Environment(\.petCardSize) private var  petCardSize

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
            self.imageContentType = .systemName(pet.type.rawValue)
        }
    }

    init() {
        self.pet = nil
        self.imageContentType = .systemName("plus")
    }

    var body: some View {
        VStack(alignment: .center, spacing: .zero) {
            image
            titleView
        }

        .foregroundStyle(AppColor.textPrimary)
        .frame(width: petCardSize.rawValue)
        .clipShape(imageCardShape)
        .shadow(color: Color.gray.opacity(0.2), radius: 3, x: 0, y: 3)
    }

    private var image: some View {
        ContentImage(contentType: imageContentType)
            .frame(
                width: petCardSize.rawValue,
                height: petCardSize.rawValue * aspectRatio
            )
            .overlay(imageCardShape.stroke(.gray, lineWidth: 0.5))
    }

    private var titleView: some View {
        Text(title)
            .font(petCardSize.font)
            .fontWeight(petCardSize.fontWeight)
            .frame(maxWidth: .infinity)
            .padding(.vertical, 4)
            .background(.white)
    }

    private var imageCardShape: some Shape {
        return .rect(
            topLeadingRadius: cornerRadius,
            bottomLeadingRadius: 0,
            bottomTrailingRadius: 0,
            topTrailingRadius: cornerRadius
        )
    }
}

#Preview {
    let container = DataController.previewContainer
    let cudi = Pet(petDTO: .cudi)
    let url = URL(string: "gogole.com")!
    cudi.avatarURL = url
    return VStack(spacing: 8) {
        RoundedPetCard(pet: cudi)
            .setPetCardSize(.small)

        RoundedPetCard(pet: cudi)
            .setPetCardSize(.medium)

        RoundedPetCard(pet: cudi)
            .setPetCardSize(.large)

        Spacer()

        HStack {
            RoundedPetCard(pet: cudi)
                .setPetCardSize(.small)
            RoundedPetCard(pet: Pet(petDTO: .brodie))
                .setPetCardSize(.small)
            RoundedPetCard()
                .setPetCardSize(.small)

        }

        RoundedPetCard()
    }
    .task {
        await InMemoryCache.shared.set(UIImage(named: "cudi"), for: url)
    }
    .modelContainer(container)
    .padding()
    .background(AppColor.softBackground)
}
