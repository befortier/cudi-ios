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
    private let cornerRadius: CGFloat = 12
    private let aspectRatio: CGFloat = 0.8
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
            self.imageContentType = .systemName("pawprint")
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
        .background(.white)
        .clipShape(RoundedRectangle(cornerRadius: cornerRadius))
        .foregroundStyle(AppColor.textPrimary)
        .frame(width: petCardSize.rawValue, height: petCardSize.rawValue * aspectRatio)
    }

    private var image: some View {
        ContentImage(contentType: imageContentType)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .overlay(imageCardShape.stroke(.gray, lineWidth: 0.5))
            .shadow(color: Color.gray.opacity(0.2), radius: 3, x: 0, y: 3)
    }

    private var titleView: some View {

        Text(title)
            .font(.caption)
            .foregroundStyle(AppColor.textPrimary)
            .padding(.vertical, 4)
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
    let container = previewModelContainer
    let cudi = Pet(petDTO: .cudi)
    let url = URL(string: "gogole.com")!
    cudi.avatarURL = url
    return HStack {
        PetCard(pet: cudi)
            .aspectRatio(contentMode: .fill)
            .setPetCardSize(.small)
            .task {
                await InMemoryCache.shared.set(UIImage(named: "cudi"), for: url)
            }

        PetCard(pet: Pet(petDTO: .brisco))
            .setPetCardSize(.small)
            .task {
                await InMemoryCache.shared.set(UIImage(named: "cudi"), for: url)
            }

        PetCard()
            .setPetCardSize(.medium)

    }
    .modelContainer(container)
    .padding()
    .background(AppColor.softBackground)
}
