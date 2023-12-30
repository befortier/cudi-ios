//
//  AsyncCachedImage.swift
//  ios-cudi
//
//  Created by Ben Fortier on 12/29/23.
//

import Foundation
import SwiftUI

@MainActor
struct AsyncCachedImage<Placeholder: View>: View {
    private var loader: ImageLoader
    private let placeholder: () -> Placeholder

    init(
        url: URL,
        @ViewBuilder placeholder: @escaping () -> Placeholder
    ) {
        self.placeholder = placeholder
        loader = .init(url: url)
    }

    var body: some View {
        content
            .task { await loader.load() }
    }

    private var content: some View {
        Group {
            if loader.image != nil {
                Image(uiImage: loader.image!)
                    .resizable()
            } else {
                placeholder()
            }
        }
    }
}
