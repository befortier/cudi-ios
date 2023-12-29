//
//  ImageLoader.swift
//  ios-cudi
//
//  Created by Ben Fortier on 12/29/23.
//

import Foundation
import UIKit
import Combine

@MainActor
class ImageLoader: ObservableObject {
    @Published var image: UIImage?

    private let url: URL
    private var cache: ImageCache
    private var cancellable: AnyCancellable?

    init(
        url: URL,
        cache: ImageCache = InMemoryCache.shared
    ) {
        self.url = url
        self.cache = cache
    }

    func load() async {
        if let cachedImage = await cache.get(for: url) {
            image = cachedImage
            return
        }

        cancellable = URLSession.shared.dataTaskPublisher(for: url)
            .map { UIImage(data: $0.data) }
            .replaceError(with: nil)
            .receive(on: DispatchQueue.main)
            .handleEvents(receiveOutput: { [weak self] image in
                Task { [weak self] in
                    guard let self else { return }
                    await cache.set(image, for: url)
                }
            })
            .assign(to: \.image, on: self)
    }

    deinit {
        cancellable?.cancel()
    }
}


