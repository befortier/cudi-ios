//
//  ImageCache.swift
//  ios-cudi
//
//  Created by Ben Fortier on 12/29/23.
//

import Foundation
import UIKit

protocol ImageCache: Actor {
    func get(for url: URL) -> UIImage?
    func set(_ image: UIImage?, for url: URL)
}

final actor InMemoryCache: ImageCache {
    static let shared = InMemoryCache()

    private let cache = NSCache<NSURL, UIImage>()

    func get(for url: URL) -> UIImage? {
        cache.object(forKey: url as NSURL)
    }

    func set(_ image: UIImage?, for url: URL) {
        guard let image else { return }
        cache.setObject(image, forKey: url as NSURL)
    }
}
