//
//  CreatePetView.swift
//  ios-cudi
//
//  Created by Ben Fortier on 12/29/23.
//

import Foundation
import SwiftUI

@MainActor
struct CreatePetView: View {
    private let imageDiameter: CGFloat = 100
    @State var selectedImage: UIImage?
    @State var selectedPetType: PetType = .dog
    @State var nameField: TextFieldState = TextFieldState(validator: PasswordValidator())

    var body: some View {
        VStack {
            addImageSection
                .padding(.bottom, 16)
            VStack(spacing: 16) {
                PetTypeSelectionView(selectedPetType: $selectedPetType)
                    .padding(.bottom, 16)
                NameTextField(textFieldState: nameField)
                Spacer()
                submitButton
                    .padding(.bottom, 32)
            }
            .padding(.horizontal, 16)
        }
        .background(AppColor.softBackground) // TODO: Back some background with bones/wiskers...
    }

    private var addImageSection: some View {
        EditableAvatarView(
            selectedImage: $selectedImage,
            petType: selectedPetType
        )
        .frame(width: imageDiameter, height: imageDiameter)
        .foregroundStyle(.gray)
        .frame(maxWidth: .infinity)
        .padding(.vertical, 12)
        .background(AppColor.background)
        .shadow(color: Color.gray.opacity(0.3), radius: 5, x: 0, y: 5)

    }

    private var submitButton: some View {
        Button {
//            self.formStatus = form.attemptSubmission()
        } label: {
            Text("Add")
                .font(.headline)
                .foregroundColor(.white)
                .padding()
                .background(Color.purple)
                .cornerRadius(10)
        }
    }
}


@MainActor
struct PetFormView: View {
    var body: some View {
        EmptyView()
    }
}


#Preview {
    CreatePetView()
}
