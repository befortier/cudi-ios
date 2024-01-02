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
    @Environment(\.imageContentMode) var imageContentMode

    var imageFrameSize: CGFloat {
        let interiorSquareDimension = circleCardSize.rawValue/2 * sqrt(2)
        // if we have fit OR default is fit use square
        if case .systemName = contentType {
            return interiorSquareDimension
        }

        if imageContentMode == .fit {
            return interiorSquareDimension

        }

        return circleCardSize.rawValue
    }

    var contentType: ImageContentType

    var body: some View {
        ContentImage(contentType: contentType)
            .frame(
                width: imageFrameSize,
                height: imageFrameSize
            )
            .frame(
                width: circleCardSize.rawValue,
                height: circleCardSize.rawValue
            )
            .clipShape(Circle())
            .overlay {
                Circle()
                    .stroke(.gray.opacity(0.15), lineWidth: 1)
            }
    }
}

#Preview {

    VStack {
        HStack {
            CircleImageView(contentType: .systemName("pawprint"))
                .setCircleCardSize(.large)

            CircleImageView(contentType: .systemName("dog"))
                .setCircleCardSize(.medium)

            CircleImageView(contentType: .systemName("dog"))
                .setCircleCardSize(.small)
        }

        HStack {

            CircleImageView(contentType: .systemName("pawprint"))
                .background(Color.yellow)

            CircleImageView(contentType: .image(UIImage(systemName: "person")!))
                .setImageContentMode(contentMode: .fill)
                .background(Color.blue)

            CircleImageView(contentType: .image(UIImage(systemName: "person")!))
                .setImageContentMode(contentMode: .fit)
                .background(Color.red)
        }
        .setCircleCardSize(.medium)
    }
}
