//
//  PetTypeSelectionView.swift
//  ios-cudi
//
//  Created by Ben Fortier on 12/30/23.
//

import Foundation
import SwiftUI

@MainActor
struct PetTypeSelectionView: View {
    @Binding var selectedPetType: PetType

    var body: some View {
        HStack(spacing: 32) {
            ForEach(PetType.allCases) { petType in
                PetTypeSelectionOption(
                    item: petType,
                    isSelected: selectedPetType == petType
                )
                .onTapGesture {
                    withAnimation {
                        selectedPetType = petType
                    }
                }
            }
        }
    }
}

#Preview {
    VStack {
        PetTypeSelectionView(selectedPetType: .constant(.dog))

        PetTypeSelectionView(selectedPetType: .constant(.cat))
    }
}
