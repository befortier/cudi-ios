//
//  String+CapitilizedFirst.swift
//  ios-cudi
//
//  Created by Ben Fortier on 1/1/24.
//

import Foundation

extension String {
    func capitalizingFirstLetter() -> String {
      return prefix(1).uppercased() + self.lowercased().dropFirst()
    }

    mutating func capitalizeFirstLetter() {
      self = self.capitalizingFirstLetter()
    }
}
