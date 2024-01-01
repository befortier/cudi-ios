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
        VStack(alignment: .leading, spacing: .zero) {
            titleView
            subtitleView
            petsSection
        }
        .padding(12)
        .background(.white)
        .clipShape(RoundedRectangle(cornerRadius: cornerRadius))
        .foregroundStyle(AppColor.textPrimary)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .shadow(color: Color.gray.opacity(0.2), radius: 3, x: 0, y: 3)
        .background(.red)
        .onFirstAppear {
            Task {
                try await Task.sleep(for: .seconds(1.0))
                try? await PetRepository(petStore: petStore).setPets(with: item.ownerPets)
            }
        }
        .onChange(of: pets) { oldValue, newValue in
            print("HERE CHANGES", oldValue, newValue)
        }
    }

    private var titleView: some View {
        Text(item.title)
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
            .font(.title3)
            .fontWeight(.semibold)
            .foregroundStyle(AppColor.textPrimary)
    }

    private var subtitleView: some View {
        Text(item.subtitle)
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
            .font(.caption)
            .foregroundStyle(.gray)
            .padding(.vertical, 4)
    }

    @ViewBuilder
    private var petsSection: some View {
        HStack {
            ForEach(pets) { pet in
                CircularPetCard(pet: pet)
                    .setPetCardSize(.small)
            }
        }
    }
}

#Preview {
    let container = DataController.previewContainer
    let walkItem = ActivityFeedItem(activityFeedDTO: .walk)

    return ScrollView {
        VStack(spacing: 24) {
            ActivityFeedCard(item: walkItem)
                .padding(.horizontal, 32)

            ActivityFeedCard(item: walkItem)
                .padding(.horizontal, 32)

            ActivityFeedCard(item: walkItem)
                .padding(.horizontal, 32)

            ActivityFeedCard(item: walkItem)
                .padding(.horizontal, 32)

        }
    }
    .modelContainer(container)
    .setAppState(.stub())
    .background(AppColor.softBackground)
}

@MainActor
struct ActivityFeedItemPetSection: View {
    let viewModel: ViewModel

    var body: some View {
        EmptyView()
    }
}
extension ActivityFeedItemPetSection {
    @Observable @MainActor
    class ViewModel {
        // TODO: When a user removes a pet how do we clean up activity feed?

        init(
            petRepository: PetRepository,
            petIDs: [Pet.ID]
        ) {
            Task { try await petRepository.setPets(with: petIDs)}

            // need to set pets but also request any that are not there
        }
    }
}
