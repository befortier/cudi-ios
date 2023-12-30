//
//  CircleImageView.swift
//  ios-cudi
//
//  Created by Ben Fortier on 12/29/23.
//

import Foundation
import SwiftUI

enum ImageContentType: Sendable, Equatable {
    case systemName(String)
    case remote(URL)
    case image(UIImage)
}


@MainActor
struct CircleImageView: View {
    @Environment(\.circleCardSize) var circleCardSize
    private let contentType: ImageContentType

    init(imageURL: URL) {
        self.contentType = .remote(imageURL)
    }

    init(systemName: String) {
        self.contentType = .systemName(systemName)
    }

    init(contentType: ImageContentType) {
        self.contentType = contentType
    }

    var body: some View {
        contentView
            .clipShape(Circle())
            .overlay {
                Circle()
                    .stroke(.gray.opacity(0.15), lineWidth: 1)
            }
            .frame(width: circleCardSize.rawValue, height: circleCardSize.rawValue)

    }

    @ViewBuilder
    private var contentView: some View {
        switch contentType {
        case .systemName(let systemName):
            Image(systemName: systemName)
                .resizable()
                .padding()
                .aspectRatio(contentMode: .fit)
        case .image(let uiImage):
            Image(uiImage: uiImage)
                .resizable()
                .aspectRatio(contentMode: .fill)
        case .remote(let imageURL):
            AsyncCachedImage(url: imageURL) {
                Circle()
                    .fill(.gray)
                    .modifier(ShimmerModifier())
            }
        }
    }
}

#Preview {
    CircleImageView(contentType: .systemName("pawprint"))
}
