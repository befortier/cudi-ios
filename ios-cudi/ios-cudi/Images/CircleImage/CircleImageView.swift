//
//  CircleImageView.swift
//  ios-cudi
//
//  Created by Ben Fortier on 12/29/23.
//

import Foundation
import SwiftUI

@MainActor
struct CircleImageView: View {
    @Environment(\.circleCardSize) var circleCardSize
    @Environment(\.circleImageContentMode) var contentMode: ContentMode?

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
        case .defaultAvatar(let defaultAvatarType):
            image(systemName: defaultAvatarType.rawValue)
        case .systemName(let systemName):
            image(systemName: systemName)
        case .image(let uiImage):
            Image(uiImage: uiImage)
                .resizable()
                .aspectRatio(contentMode: contentMode ?? .fill)
        case .remote(let imageURL):
            AsyncCachedImage(url: imageURL) {
                Circle()
                    .fill(.gray)
                    .modifier(ShimmerModifier())
            }
        }
    }

    private func image(systemName: String) -> some View {
        Image(systemName: systemName)
            .resizable()
            .padding()
            .aspectRatio(contentMode: contentMode ?? .fit)
    }
}

#Preview {

    VStack {
        HStack {
            CircleImageView(contentType: .systemName("pawprint"))
                .setCircleCardSize(.large)

            CircleImageView(contentType: .systemName("pawprint"))
                .setCircleCardSize(.medium)

            CircleImageView(contentType: .systemName("pawprint"))
                .setCircleCardSize(.small)
        }

        HStack {

            CircleImageView(contentType: .systemName("pawprint"))
            CircleImageView(contentType: .defaultAvatar(.cat))
            CircleImageView(contentType: .defaultAvatar(.dog))

            CircleImageView(contentType: .image(UIImage(systemName: "person")!))
                .setCircleAspectRatio(contentMode: .fill)


        }
        .setCircleCardSize(.medium)
    }
}
