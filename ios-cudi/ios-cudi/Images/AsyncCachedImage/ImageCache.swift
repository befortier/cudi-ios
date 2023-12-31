//
//  ImageCache.swift
//  ios-cudi
//
//  Created by Ben Fortier on 12/29/23.
//

import Foundation
import UIKit
import Combine
protocol ImageCache: Actor {
    var imageUpdatePublisher: AnyPublisher<(URL, UIImage?), Never> { get }
    func get(for url: URL) -> UIImage?
    func set(_ image: UIImage?, for url: URL)
}

final actor InMemoryCache: ImageCache {
    static let shared = InMemoryCache()

    private let cache = NSCache<NSURL, UIImage>()
    var _imageUpdatePublisher = PassthroughSubject<(URL, UIImage?), Never>()
    var imageUpdatePublisher: AnyPublisher<(URL, UIImage?), Never> {_imageUpdatePublisher.share().eraseToAnyPublisher() }

    func get(for url: URL) -> UIImage? {
        cache.object(forKey: url as NSURL)
    }

    func set(_ image: UIImage?, for url: URL) {
        _imageUpdatePublisher.send((url, image))
        guard let image else {
            cache.removeObject(forKey: url as NSURL)
            return
        }
        cache.setObject(image, forKey: url as NSURL)
    }
}
