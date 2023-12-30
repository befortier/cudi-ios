//
//  EnvironmentStore.swift
//  ios-cudi
//
//  Created by Ben Fortier on 12/30/23.
//

import Foundation

final actor EnvironmentStore {
    @Published var current: EnvironmentType

    init(current: EnvironmentType) async {
        self.current = current
    }
}
