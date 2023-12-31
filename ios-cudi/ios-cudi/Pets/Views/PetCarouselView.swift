//
//  PetCarouselView.swift
//  ios-cudi
//
//  Created by Ben Fortier on 12/29/23.
//

import Foundation
import SwiftUI

@MainActor
struct ScrollablePetList: View {
    let pets: [Pet]

    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 24) {
                ForEach(pets) { pet in
                    navigablePetCard(pet: pet)
                }
                addPetCard
            }
            .padding([.horizontal, .bottom], 8)
        }
    }

    private func navigablePetCard(pet: Pet) -> some View {
        NavigationLink {
            PetDetailView(pet: pet)
        } label: {
            RoundedPetCard(pet: pet)
        }
    }

    private var addPetCard: some View {
        NavigationLink {
            CreatePetView(form: .init())
        } label: {
            RoundedPetCard()
        }
    }
}

import SwiftData

#Preview {
    let container = DataController.previewContainer

    let pets = [PetDTO.cudi].map { Pet(petDTO: $0 )}
    return NavigationStack {
        ScrollablePetList(pets: pets)
            .padding()
            .background(AppColor.softBackground)
            .modelContainer(container)
    }
}
