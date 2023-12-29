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

    var body: some View {
        Group {
            if let user = users.first {
                MainTabView(user: user)
            } else if let userID = currentUserID {
                ProgressView()
                    .progressViewStyle(.automatic)
                    .task {
                        do {
                            let user = try await viewModel.restoreCurrentUser(userID: userID)
                            modelContext.insert(user)
                        } catch {
                            print("ERROR")
                        }
                    }
            } else {
                SplashScreen()
            }
        }
        .navigationViewStyle(.stack)
    }
}

extension RootView {
    @MainActor
    class ViewModel: ObservableObject {

        init() {}

        func restoreCurrentUser(userID: String) async throws -> User {
            print("HERE RESTORING")
            return .stub
        }
    }
}
