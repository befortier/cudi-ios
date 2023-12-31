//
//  EditableAvatarView+ViewModel.swift
//  ios-cudi
//
//  Created by Ben Fortier on 12/31/23.
//

import Foundation
import SwiftUI

extension EditableAvatarView {

    @MainActor @Observable
    class ViewModel {
        var hasEditableImage: Bool
        var selectedImage: UIImage? = nil
        var imageContent: ImageContentType

        private let domain: AvatarDomainType
        private let imageCache = InMemoryCache.shared

        init(
            selectedImage: UIImage?,
            imageContent: ImageContentType,
            domain: AvatarDomainType
        ) {
            self.imageContent = imageContent
            self.domain = domain
            self.selectedImage = selectedImage
            self.hasEditableImage = selectedImage != nil || imageContent.hasBackedImage
        }

        func changed(to newImage: UIImage?) {
            
            // if the image was loaded via a url, update the url in cache
            if case .remote(let url) = imageContent {
                Task {
                    await imageCache.set(newImage, for: url)
                }
            } else if let newImage {
                // if the image was not via a url, set it to be the image manually
                // make sure the image was not remote because if it was we want to keep it as remote
                imageContent = .image(newImage)
            } 


            // if we deleted the selected image
            if newImage == nil {
                // TODO: What if the image gets set, we upload, is this component rerendedred with default type (probably need to manually do that
                // The above edge case is in case we call remove after
                imageContent = .systemName(domain.systemName)
            }

            selectedImage = newImage
            setHasEditableImage()
        }

        private func setHasEditableImage() {
            self.hasEditableImage = selectedImage != nil || imageContent.hasBackedImage
        }
    }
}
