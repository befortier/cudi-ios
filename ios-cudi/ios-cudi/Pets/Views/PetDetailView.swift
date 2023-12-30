//
//  PetDetailView.swift
//  ios-cudi
//
//  Created by Ben Fortier on 12/29/23.
//

import Foundation
import SwiftUI

@MainActor
struct PetDetailView: View {
    let pet: Pet

    var body: some View {
        Text("Detail \(pet.name)")
    }
}
