//
//  MainTabView.swift
//  ios-cudi
//
//  Created by Ben Fortier on 12/27/23.
//

import Foundation
import SwiftUI
import SwiftData

struct MainTabView: View {
    @Environment(\.modelContext) var modelContext
    
    @AppStorage(UserDefaultKey.currentUserID.rawValue)
    private var currentUserID: String?

    let user: User
    
    var body: some View {
        NavigationStack {
            Button {
                modelContext.delete(user)
                currentUserID = nil
            } label: {
                Text("MainTabView")
            }
        }
    }
}
