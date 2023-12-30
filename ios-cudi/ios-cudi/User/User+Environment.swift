//
//  User+Environment.swift
//  ios-cudi
//
//  Created by Ben Fortier on 12/29/23.
//

import Foundation
import SwiftUI

private struct UserEnvironmentKey: EnvironmentKey {
    static let defaultValue = User.stub
}

extension EnvironmentValues {
  var user: User {
    get { self[UserEnvironmentKey.self] }
    set { self[UserEnvironmentKey.self] = newValue }
  }
}

//@MainActor
//private struct UserStoreEnvironmentKey: EnvironmentKey {
//    static let defaultValue = UserStore.stub
//}
//
//extension EnvironmentValues {
//  var userStore: UserStore {
//    get { self[UserStoreEnvironmentKey.self] }
//    set { self[UserStoreEnvironmentKey.self] = newValue }
//  }
//}
