//
//  ContentView.swift
//  ios-cudi
//
//  Created by Ben Fortier on 12/27/23.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @AppStorage(UserDefaultKey.currentUserID.rawValue)
    private var currentUserID: String?

    var body: some View {
        RootView()
    }
}

#Preview {
    ContentView()
        .modelContainer(for: User.self, inMemory: true)
}
