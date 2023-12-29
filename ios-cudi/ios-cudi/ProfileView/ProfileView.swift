//
//  ProfileView.swift
//  ios-cudi
//
//  Created by Ben Fortier on 12/29/23.
//

import Foundation
import SwiftUI

struct ProfileView: View {

    var body: some View {
        NavigationView {
            VStack(spacing: .zero) {
                ProfileHeaderView()
                    .shadow(color: Color.gray.opacity(0.3), radius: 5, x: 0, y: 5)

                Divider()

                Spacer()
                Text("content")
            }

        }
    }
}

#Preview {
    ProfileView()
}
