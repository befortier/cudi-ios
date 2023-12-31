//
//  EditableAvatarView.swift
//  ios-cudi
//
//  Created by Ben Fortier on 12/30/23.
//

import Foundation
import SwiftUI

@MainActor
struct EditableAvatarView: View {
    @Environment(\.circleCardSize) var circleCardSize
    private let imageCache = InMemoryCache.shared

    private var imageDiameter: CGFloat {
        circleCardSize.rawValue * 0.1
    }

    private var imagePadding: CGFloat {
        circleCardSize.rawValue * 0.085
    }

    @Binding private var selectedImage: UIImage?
    private var viewModel: ViewModel
    private let domain: AvatarDomainType

    // MARK: Init

    init(
        selectedImage: Binding<UIImage?>,
        domain: AvatarDomainType,
        url: URL
    ) {
        self._selectedImage = selectedImage
        self.domain = domain
        
        let imageContent: ImageContentType = if let selectedImage = selectedImage.wrappedValue {
            .image(selectedImage)
        } else {
            .remote(url)
        }
        self.viewModel = ViewModel(
            selectedImage: selectedImage.wrappedValue,
            imageContent: imageContent,
            domain: domain
        )
    }

    init(
        selectedImage: Binding<UIImage?>,
        domain: AvatarDomainType
    ) {
        self._selectedImage = selectedImage
        self.domain = domain
        
        let imageContent: ImageContentType = if let selectedImage = selectedImage.wrappedValue {
            .image(selectedImage)
        } else {
            .systemName(domain.systemName)
        }
        self.viewModel = ViewModel(
            selectedImage: selectedImage.wrappedValue,
            imageContent: imageContent,
            domain: domain
        )
    }

    init(
        selectedImage: Binding<UIImage?>,
        petType: PetType
    ) {
        self.init(
            selectedImage: selectedImage,
            domain: .pet(petType)
        )
    }

    @State private var showImagePicker = false

    var body: some View {
        CircleImageView(contentType: viewModel.imageContent)
            .overlay(editIconView, alignment: .bottomTrailing)
            .overlay(removeIconView, alignment: .topTrailing)
            .onChange(of: selectedImage) { _, newImage in
                viewModel.changed(to: newImage)
            }
    }

    @ViewBuilder
    private var removeIconView: some View {
        if viewModel.hasEditableImage {
            Button {
                selectedImage = nil
                viewModel.changed(to: nil)
            } label: {
                Image(systemName: "trash")
                    .resizable()
                    .frame(width: imageDiameter, height: imageDiameter)
                    .aspectRatio(contentMode: .fit)
                    .padding(imagePadding)
                    .background(
                        RoundedRectangle(cornerRadius: imageDiameter)
                            .fill(AppColor.background.opacity(0.8))
                    )
                    .foregroundStyle(.red)
            }
        }
    }

    private var editIconView: some View {
        Button {
            showImagePicker = true
        } label: {
            Image(systemName: viewModel.hasEditableImage ? "pencil" : "plus")
                .resizable()
                .frame(width: imageDiameter, height: imageDiameter)
                .aspectRatio(contentMode: .fit)
                .padding(imagePadding)
                .background(
                    RoundedRectangle(cornerRadius: imageDiameter)
                        .fill(AppColor.backgroundAlt.opacity(0.8))
                )
                .foregroundStyle(.gray)
        }
        .sheet(isPresented: $showImagePicker) {
            ImagePicker(selectedImage: $selectedImage)
        }
    }
}

#Preview {
    @State var image: UIImage?

    return VStack {
        EditableAvatarView(
            selectedImage: $image,
            domain: .pet(.dog)
        )
            .setCircleCardSize(.large)

        EditableAvatarView(
            selectedImage: $image,
            domain: .person
        )
            .setCircleCardSize(.medium)

        EditableAvatarView(
            selectedImage: $image,
            petType: .cat
        )
            .setCircleCardSize(.small)
    }
}
