//
//  PetTypeSelectionOption.swift
//  ios-cudi
//
//  Created by Ben Fortier on 1/1/24.
//

import Foundation
import SwiftUI

@MainActor
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
