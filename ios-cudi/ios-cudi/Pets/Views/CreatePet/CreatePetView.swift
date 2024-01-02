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
    @Environment(\.dismiss) var dismiss
    @Environment(\.petStore) var petStore
    private let imageDiameter: CGFloat = 100
    var form: PetForm

    var body: some View {
        VStack {
            addImageSection
                .padding(.bottom, 16)
            VStack(spacing: 16) {
                PetTypeSelectionView(
                    selectedPetType: Binding<PetType>(get: { form.selectedPetType }, set: { form.selectedPetType = $0 })
                )
                .padding(.bottom, 16)

                NameTextField(textFieldState: form.nameState, domainType: .pet(form.selectedPetType))
                BirthdayTextField(textFieldState: form.birthdayState)

                Spacer()
                submitButton
                    .padding(.bottom, 32)
            }
            .padding(.horizontal, 16)
        }
        .minamlistNavBar()
        .background(.softBackground) // TODO: Back some background with bones/wiskers...
    }

    private var addImageSection: some View {
        EditableAvatarView(
            selectedImage: Binding<UIImage?>(get: { form.image }, set: { form.image = $0 }),
            petType: form.selectedPetType
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
            guard let addPetDTO = form.attemptSubmission() else {
                return
            }

            Task {
                // TODO: Clean up image cache if fails.
                try await PetRepository(petStore: petStore).addPet(pet: addPetDTO)
                dismiss()
            }
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
    CreatePetView(form: .init())
}
