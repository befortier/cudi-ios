//
//  ActivityFeedCard.swift
//  ios-cudi
//
//  Created by Ben Fortier on 12/31/23.
//

import Foundation
import SwiftUI
import SwiftData

@MainActor
struct ActivityFeedCard: View {
    @Environment(\.petStore) var petStore
    @Environment(\.activityCardSize) var activityCardSize
    @Query var pets: [Pet]

    private let cornerRadius: CGFloat = 12
    private let aspectRatio: CGFloat = 0.5

    let item: ActivityFeedItem

    init(item: ActivityFeedItem) {
        self.item = item
        let itemIDs = item.ownerPets
        self._pets = Query(filter: #Predicate {
            itemIDs.contains($0.id)
      }, sort: \.name)
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            // TODO: some badge for type
            // Some Color on the card
            descriptionView
            Divider()
            activityBar
                .padding(.vertical, 4)
            petsSection
            Divider()
                .padding(.vertical, 4)
            bottomSection

        }
        .padding(12)
        .background(.white)
        .clipShape(RoundedRectangle(cornerRadius: cornerRadius))
        .foregroundStyle(AppColor.textPrimary)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .shadow(color: Color.gray.opacity(0.2), radius: 3, x: 0, y: 3)
        .onFirstAppear {
            Task {
                try? await PetRepository(petStore: petStore).setPets(with: item.ownerPets)
            }
        }
    }

    private var descriptionView: some View {
        VStack(spacing: 8) {
            HStack(spacing: 8) {
                ActivityItemTypeIcon(type: item.type)
                titleView
            }
            subtitleView
        }
    }

    private var titleView: some View {
        Text(item.title)
            .frame(maxWidth: .infinity, alignment: .leading)
            .font(.title3)
            .fontWeight(.semibold)
            .foregroundStyle(AppColor.textPrimary)
    }

    private var subtitleView: some View {
        Text(item.subtitle)
            .frame(maxWidth: .infinity,  alignment: .leading)
            .font(.caption)
            .foregroundStyle(.gray)
        
//            .background(.blue)
    }

    @ViewBuilder
    private var petsSection: some View {
        HStack {
            ForEach(Array(pets.prefix(3))) { pet in
                CircularPetCard(pet: pet)
            }

            if pets.count > 3 {
                CircularPetCard(title: "3 friends", imageContentType: .systemName("plus"))
            }
        }
        .setPetCardSize(.small)

    }

    @ViewBuilder
    private var activityBar: some View {
        HStack {
            
        }
        // Should have number of pictures, videos, filters
        Capsule()
            .fill(.blue)
            .frame(height: 16)
    }

    @ViewBuilder
    private var bottomSection: some View {
        HStack(alignment: .bottom) {
            timeSinceText
            Spacer()
            posterText
        }
    }

    private var posterText: some View {
        Text("Pups Pet Club")
            .font(.caption)
            .foregroundStyle(.gray)
    }

    private var timeSinceText: some View {
        Text("12s ago")
            .font(.caption)
            .foregroundStyle(.gray)
    }
}

#Preview {
    let container = DataController.previewContainer
    let walkItem = ActivityFeedItem(activityFeedDTO: .walk)
    let playdate = ActivityFeedItem(activityFeedDTO: .playdate)
    let food = ActivityFeedItem(activityFeedDTO: .food)

    return ScrollView {
        VStack(spacing: 24) {
            ActivityFeedCard(item: walkItem)
                .padding(.horizontal, 32)

            ActivityFeedCard(item: playdate)
                .padding(.horizontal, 32)

            ActivityFeedCard(item: food)
                .padding(.horizontal, 32)

            ActivityFeedCard(item: walkItem)
                .padding(.horizontal, 32)

        }
    }
    .modelContainer(container)
    .setAppState(.stub())
    .background(AppColor.softBackground)
}
