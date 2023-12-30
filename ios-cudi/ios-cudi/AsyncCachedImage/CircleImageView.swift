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
    private enum ContentType: Sendable, Equatable {
        case systemName(String)
        case remote(URL)
    }

    private let content: ContentType

    init(imageURL: URL) {
        self.content = .remote(imageURL)
    }

    init(systemName: String) {
        self.content = .systemName(systemName)
    }

    var body: some View {
        contentView
            .clipShape(Circle())
            .overlay(
                Circle()
                    .stroke(.gray.opacity(0.15), lineWidth: 1)
            )
    }

    @ViewBuilder
    private var contentView: some View {
        switch content {
        case .systemName(let systemName):
            Image(systemName: systemName)
                .resizable()
                .aspectRatio(contentMode: .fit)
        case .remote(let imageURL):
            AsyncCachedImage(url: imageURL) {
                Circle()
                    .fill(.gray)
                    .modifier(ShimmerModifier())
            }
        }
    }
}
