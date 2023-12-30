//
//  ProfileListItem.swift
//  ios-cudi
//
//  Created by Ben Fortier on 12/29/23.
//

import Foundation
import SwiftUI

struct ProfileListItem<Destination: View>: View {
    let icon: Image
    let title: String
    let destination: Destination

    var body: some View {
        NavigationLink(destination: destination) {
            HStack(spacing: 16) {
                icon
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 30, height: 30)
                    .foregroundColor(AppColor.textPrimary)

                Text(title)
                    .font(.headline)
                    .foregroundColor(AppColor.textPrimary)

                Spacer()

                Image(systemName: "chevron.right")
                    .foregroundColor(.gray)
            }
            .padding()
            .background(Color.white)
            .cornerRadius(10)
            .shadow(color: Color.gray.opacity(0.2), radius: 5, x: 0, y: 3)
        }
    }
}


#Preview {
    VStack(spacing: 8) {
        ProfileListItem(icon: Image(systemName: "pawprint.fill"), title: "Pets", destination: Text("Hi"))
        ProfileListItem(icon: Image(systemName: "gearshape.fill"), title: "Settings", destination: Text(
        "hi2"))
        ProfileListItem(icon: Image(systemName: "person.fill"), title: "Profile Info", destination: Text("hi3"))
    }
    .padding()
    .background(AppColor.softBackground)
}
