//
//  ImageContentType.swift
//  ios-cudi
//
//  Created by Ben Fortier on 12/30/23.
//

import Foundation
import UIKit

enum ImageContentType: Sendable, Equatable {
    case systemName(String)
    case remote(URL)
    case image(UIImage)

    var hasBackedImage: Bool {
        guard case .remote = self else {
            return false
        }
        return true
    }

    var selectedImage: UIImage? {
        guard case .image(let uIImage) = self else {
            return nil
        }
        return uIImage
    }
}
