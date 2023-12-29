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


extension View {
  func setUser(_ user: User) -> some View {
    environment(\.user, user)
  }
}
