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
            .accentColor(AppColor.textPrimary) // Customize accent color (optional)
        }
    }
}

struct ActivityFeedListView: View {
    var body: some View {
        NavigationView {
            Text("content")
                .navigationTitle("Activity Feed")
        }
    }
}

struct StaysListView: View {
    var body: some View {
        NavigationView {
            Text("content")
                .navigationTitle("Stays")
        }
    }
}

#Preview {
    MainTabView()
        .setUser(.stub)
}
