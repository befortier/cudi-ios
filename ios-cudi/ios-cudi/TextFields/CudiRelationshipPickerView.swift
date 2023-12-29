//
//  CudiRelationshipPickerView.swift
//  ios-cudi
//
//  Created by Ben Fortier on 12/28/23.
//

import Foundation
import SwiftUI

@MainActor
struct CudiRelationshipPickerView: View {
    @Binding var cudiRelationship: CudiRelationship

    var body: some View {
        Picker("How are you connected to Cudi?", selection: $cudiRelationship) {
            ForEach(CudiRelationship.allCases) { relationship in
                Text(relationship.rawValue.capitalized)
                    .tag(relationship)
            }
        }
        .pickerStyle(.segmented)
    }
}

