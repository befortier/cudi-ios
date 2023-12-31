//
//  PetTypeSelectionView.swift
//  ios-cudi
//
//  Created by Ben Fortier on 12/30/23.
//

import Foundation
import SwiftUI

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

struct PetTypeSelectionOption: View {
    var item: PetType
    var isSelected: Bool = false

    private var systemName: String {
        switch item {
        case .dog:
            "pawprint"
        case .cat:
            "cat"
        }
    }

    var body: some View {
        VStack {
            Text(item.rawValue.capitalized)
                .font(.footnote)
                .fontWeight(.medium)
                .foregroundColor(isSelected ? .black : .gray)
                .background(Color.clear)
                .multilineTextAlignment(.center)
            Image(systemName: systemName)
                .renderingMode(isSelected ? .original : .template)
                .resizable()
                .frame(width: 24, height: 24)
                .scaledToFit()
                .foregroundColor(isSelected ? .black : .gray)
        }
    }

}

#Preview {
    VStack {
        PetTypeSelectionView(selectedPetType: .constant(.dog))

        PetTypeSelectionView(selectedPetType: .constant(.cat))
    }
}
