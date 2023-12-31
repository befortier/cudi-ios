//
//  ProfileView.swift
//  ios-cudi
//
//  Created by Ben Fortier on 12/29/23.
//

import Foundation
import SwiftUI

@MainActor
struct ProfileView: View {
    @Environment(\.petStore) var petStore

    var body: some View {
        NavigationStack {
            VStack(spacing: .zero) {
                headerView
                Divider()
                    .padding(.bottom, 24)
                petsSection
                    .padding(.horizontal, 16)
                    .padding(.bottom, 24)
                listItemsView
                    .padding(.horizontal, 16)

                Spacer()

            }
            .background(AppColor.softBackground)
        }
    }

    private var petsSection: some View {
        Section {
            ScrollablePetList(pets: petStore.pets)
        } header: {
            Text("Pets")
                .frame(maxWidth: .infinity, alignment: .leading)
                .font(.title2)
                .fontWeight(.bold)
                .foregroundStyle(AppColor.textPrimary)
        }
    }

    private var listItemsView: some View {
        VStack(spacing: 8) {
            ProfileListItem(icon: Image(systemName: "person.fill"), title: "Profile", destination: Text("hi3"))
            ProfileListItem(icon: Image(systemName: "pawprint.fill"), title: "Pets", destination: Text("Hi"))
            ProfileListItem(icon: Image(systemName: "gearshape.fill"), title: "Settings", destination: Text(
            "hi2"))
        }
    }

    private var headerView: some View {
        ProfileHeaderView()
            .padding(.vertical, 24)
            .padding(.bottom, 8)
            .frame(maxWidth: .infinity)
            .background(
                LandingBackgroundView().ignoresSafeArea()
            )
            .shadow(color: Color.gray.opacity(0.3), radius: 5, x: 0, y: 5)
    }
}

#Preview {
    let container = previewModelContainer
    
    return ProfileView()
        .modelContainer(container)
}
