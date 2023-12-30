//
//  MainTabView.swift
//  ios-cudi
//
//  Created by Ben Fortier on 12/27/23.
//

import Foundation
import SwiftUI
import SwiftData

import SwiftUI

struct MainTabView: View {
    @State private var selectedTab = Tab.activityFeed
    @Environment(\.modelContext) var modelContext: ModelContext
    @Environment(\.user) var user: User
    @Environment(\.petStore) var petStore: PetStore

    @AppStorage(UserDefaultKey.currentUserID.rawValue)
    private var currentUserID: String?

    enum Tab {
        case activityFeed
        case stays
        case profile
    }

    var body: some View {
        NavigationStack {
            TabView(selection: $selectedTab) {
                ActivityFeedListView()
                    .tabItem {
                        Image(systemName: "list.bullet")
                    }
                    .tag(Tab.activityFeed)

                StaysListView()
                    .tabItem {
                        Image(systemName: "house.fill")
                    }
                    .tag(Tab.stays)

                ProfileView()
                    .tabItem {
                        Image(systemName: "person.fill")
                    }
                    .tag(Tab.profile)

            }
            .onFirstAppear {
                Task { try? await petStore.loadPets() }
            }
            .accentColor(AppColor.textPrimary) // Customize accent color (optional)
        }
    }
}

struct ActivityFeedListView: View {
    @Environment(\.petStore) var petStore: PetStore
    @Environment(\.modelContext) var modelContext: ModelContext
    @Environment(\.user) var user: User

    @Query var pets: [Pet]

    var body: some View {
        NavigationStack {
            Button("Clear pets") {
                petStore.removePets()
            }

            Button("Add pets") {
                Task { try? await petStore.loadPets() }
            }

            Button("Add cudi to \(petStore.pets.count) \(pets.count)") {
                modelContext.insert(Pet(petDTO: .cudi))
            }

            Button("Logout") {
                petStore.removePets()
                modelContext.delete(user)
            }
                .navigationTitle("Activity Feed")
        }
    }
}

struct StaysListView: View {
    var body: some View {
        NavigationStack {
            Text("content")
                .navigationTitle("Stays")
        }
    }
}

#Preview {
    MainTabView()
        .setAppState(.stub())
}
