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

    var contentType: ImageContentType

    var body: some View {
        ContentImage(contentType: contentType)
            .frame(width: circleCardSize.rawValue, height: circleCardSize.rawValue)
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

            CircleImageView(contentType: .systemName("pawprint"))
                .setCircleCardSize(.medium)

            CircleImageView(contentType: .systemName("pawprint"))
                .setCircleCardSize(.small)
        }

        HStack {

            CircleImageView(contentType: .systemName("pawprint"))

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
