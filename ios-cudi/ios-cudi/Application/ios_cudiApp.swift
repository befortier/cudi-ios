//
//  ios_cudiApp.swift
//  ios-cudi
//
//  Created by Ben Fortier on 12/27/23.
//

import SwiftUI
import SwiftData

@main
struct ios_cudiApp: App {
    var body: some Scene {
        WindowGroup {
            RootView()
        }
        .modelContainer(sharedModelContainer)
    }
}

var sharedModelContainer: ModelContainer = {
    let schema = Schema([
        Pet.self,
        User.self
    ])
    let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

    do {
        return try ModelContainer(for: schema, configurations: [modelConfiguration])
    } catch {
        fatalError("Could not create ModelContainer: \(error)")
    }
}()


@MainActor
class DataController {
    static var previewContainer: ModelContainer = {
        do {
            let schema = Schema([
                Pet.self,
                User.self
            ])
            let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: true)
            let container = try ModelContainer(for: schema, configurations: [modelConfiguration])
//            container.mainContext.insert(User.stub)
            return container
        } catch {
            fatalError("Failed to create model container for previewing: \(error.localizedDescription)")
        }
    }()
}


