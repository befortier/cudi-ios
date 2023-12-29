//
//  UserDefaults+PropertyWrapper.swift
//  ios-cudi
//
//  Created by Ben Fortier on 12/27/23.
//

import Foundation

@propertyWrapper
struct UserDefault<T: Codable> {
    let key: UserDefaultKey

    init(_ key: UserDefaultKey) {
        self.key = key
    }

    var wrappedValue: T? {
        get {
            UserDefaults.standard.object(forKey: key.rawValue) as? T
        }
        set {
            UserDefaults.standard.set(newValue, forKey: key.rawValue)
        }
    }
}


enum UserDefaultKey: String, RawRepresentable {
    case currentUserID
}
