//
//  ContentImage.swift
//  ios-cudi
//
//  Created by Ben Fortier on 12/31/23.
//

import Foundation
import SwiftUI

@MainActor
struct ContentImage: View {
    @Environment(\.imageContentMode) var contentMode: ContentMode?

    var contentType: ImageContentType

    var body: some View {
        contentView
    }

    @ViewBuilder
    private var contentView: some View {
        switch contentType {
        case .systemName(let systemName):
            Image(systemName: systemName)
                .resizable()
                .aspectRatio(contentMode: contentMode ?? .fit)
        case .image(let uiImage):
            Image(uiImage: uiImage)
                .resizable()
                .aspectRatio(contentMode: contentMode ?? .fill)
        case .remote(let imageURL):
            AsyncCachedImage(url: imageURL) {
                Color.gray
                    .modifier(ShimmerModifier())
            }
        }
    }
}
