//
//  AddPetView.swift
//  ios-cudi
//
//  Created by Ben Fortier on 12/29/23.
//

import Foundation
import SwiftUI

@MainActor
struct AddPetView: View {
    private let imageDiameter: CGFloat = 100
    @State var selectedImage: UIImage?

    var body: some View {
        VStack {
            addImageSection
            Spacer()

        }
    }

    private var addImageSection: some View {
        EditableAvatarView(
            selectedImage: $selectedImage,
            defaultImage: .systemName("person")
        )
        .frame(width: imageDiameter, height: imageDiameter)
        .foregroundStyle(.gray)
        .frame(maxWidth: .infinity)
        .padding(.vertical, 12)
        .background(AppColor.background)
    }
}


@MainActor
struct PetFormView: View {
    var body: some View {
        EmptyView()
    }
}


#Preview {
    AddPetView()
}
