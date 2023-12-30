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
            HStack(spacing: 16) {
                ForEach(pets) { pet in
                    NavigationLink {
                        PetDetailView(pet: pet)
                    } label: {
                        PetItem(pet: pet)
                    }
                }
            }
            .padding(.horizontal)
        }
    }
}

#Preview {

    let pets = [PetDTO.cudi].map { Pet(petDTO: $0 )}
    return NavigationStack {
        ScrollablePetList(pets: pets)
            .padding()
            .background(AppColor.softBackground)
    }
}
