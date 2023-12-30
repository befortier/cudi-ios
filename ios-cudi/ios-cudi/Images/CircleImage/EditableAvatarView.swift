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

    private var imageDiameter: CGFloat {
        circleCardSize.rawValue * 0.1
    }

    private var imagePadding: CGFloat {
        circleCardSize.rawValue * 0.085
    }

    private let defaultImage: ImageContentType
    @Binding private var selectedImage: UIImage?
    private var url: URL?

    // MARK: Init
    
    init(
        selectedImage: Binding<UIImage?>,
        defaultImage: ImageContentType
    ) {
        self._selectedImage = selectedImage
        self.defaultImage = defaultImage
        self.url = nil
    }

    init(
        selectedImage: Binding<UIImage?>,
        url: URL
    ) {
        self._selectedImage = selectedImage
        self.defaultImage = .remote(url)
        self.url = url
    }

    init(
        selectedImage: Binding<UIImage?>,
        defaultAvatar: DefaultAvatarType
    ) {
        self.init(
            selectedImage: selectedImage,
            defaultImage: .systemName(defaultAvatar.rawValue)
        )
    }

    init(
        selectedImage: Binding<UIImage?>,
        petType: PetType
    ) {
        self.init(
            selectedImage: selectedImage,
            defaultAvatar: DefaultAvatarType(petType: petType)
        )
    }

    @State private var showImagePicker = false

    var body: some View {
        content
            .overlay(editIconView, alignment: .bottomTrailing)
    }

    @ViewBuilder
    private var content: some View {
        if let selectedImage {
            CircleImageView(contentType: .image(selectedImage))
        } else  {
            CircleImageView(contentType: defaultImage)
        }
    }

    private var editIconView: some View {
        Button {
            showImagePicker = true
        } label: {
            Image(systemName: selectedImage == nil ? "plus" : "pencil")
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
        .onChange(of: selectedImage) { _, newImage in
            // if we have a url to update
            guard let url else { return }
            Task { await InMemoryCache.shared.set(newImage, for: url) }
        }
    }
}

#Preview {
    @State var image: UIImage?

    return VStack {
        EditableAvatarView(selectedImage: $image, defaultImage: .systemName("pawprint"))
            .setCircleCardSize(.large)

        EditableAvatarView(selectedImage: $image, defaultAvatar: .person)
            .setCircleCardSize(.medium)

        EditableAvatarView(selectedImage: $image, petType: .cat)
            .setCircleCardSize(.small)
    }
}
