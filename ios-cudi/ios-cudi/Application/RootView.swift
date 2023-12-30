//
//  RootView.swift
//  ios-cudi
//
//  Created by Ben Fortier on 12/27/23.
//

import Foundation
import SwiftUI
import SwiftData

@MainActor
struct RootView: View {
    @AppStorage(UserDefaultKey.currentUserID.rawValue)
    private var currentUserID: String?

    @StateObject private var viewModel = ViewModel()
    @Environment(\.modelContext) var modelContext
    @Query private var users: [User]

    @State private var appState: AppState?

    var body: some View {
        Group {
            if let user = users.first {
                let appState = appState ?? AppState(
                    modelContext: modelContext,
                    user: user
                )
                MainTabView()
                    .setAppState(appState)
                    .onFirstAppear {
                        self.appState = appState
                    }
            } else if let userID = currentUserID {
                fetchRemoteUserProgressView(userID: userID)
            } else {
                SplashScreen()
            }
        }
        .navigationViewStyle(.stack)
    }

    private func fetchRemoteUserProgressView(userID: User.ID) -> some View {
        ProgressView()
            .progressViewStyle(.automatic)
            .task {
                do {
                    let user = try await viewModel.restoreCurrentUser(userID: userID)
                    modelContext.insert(user)
                } catch {}
            }
    }
}

extension RootView {
    @MainActor
    class ViewModel: ObservableObject {

        init() {}

        func restoreCurrentUser(userID: String) async throws -> User {
            return .stub
        }
    }
}


#Preview {
    RootView()
        .modelContainer(for: User.self, inMemory: true)
        .modelContainer(for: Pet.self, inMemory: true)
}
