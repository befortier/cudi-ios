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

    var contentType: ImageContentType

    var body: some View {
        contentView
            .frame(width: circleCardSize.rawValue, height: circleCardSize.rawValue)
            .clipShape(Circle())
            .overlay {
                Circle()
                    .stroke(.gray.opacity(0.15), lineWidth: 1)
            }

    }

    @ViewBuilder
    private var contentView: some View {
        switch contentType {
        case .systemName(let systemName):
            Image(systemName: systemName)
                .resizable()
                .padding()
                .aspectRatio(contentMode: contentMode ?? .fit)
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

            CircleImageView(contentType: .image(UIImage(systemName: "person")!))
                .setCircleAspectRatio(contentMode: .fill)
                .background(Color.blue)

            CircleImageView(contentType: .image(UIImage(systemName: "person")!))
                .setCircleAspectRatio(contentMode: .fit)
                .background(Color.red)
        }
        .setCircleCardSize(.medium)
    }
}
