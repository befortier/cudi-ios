////
////  UserStore.swift
////  ios-cudi
////
////  Created by Ben Fortier on 12/29/23.
////
//
//import Foundation
//import SwiftData
//import SwiftUI
//
//@MainActor @Observable
//class UserStore {
//    private let modelContext: ModelContext
//    private(set) var current: User? {
//        didSet {
//            if let current {
//                modelContext.insert(current)
//            } else if let oldValue {
//                modelContext.delete(oldValue)
//            }
//        }
//    }
//
//    @Query @ObservationIgnored var users: [User]
//
//    init(modelContext: ModelContext) {
//        self.modelContext = modelContext
//        self.current = users.first
//    }
//
//    func loadUser(for userID: User.ID) {
//        // TODO: Network request here
//        self.current = .stub
//    }
//
//    func storeUser(_ user: User) {
//        self.current = user
//    }
//}
//
//@MainActor
//extension UserStore {
//    static var stub = try! UserStore(modelContext: .init(.init(for: User.self, configurations: .init(isStoredInMemoryOnly: true))))
//}
