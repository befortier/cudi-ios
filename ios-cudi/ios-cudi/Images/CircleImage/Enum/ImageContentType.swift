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
    case defaultAvatar(DefaultAvatarType)
}
