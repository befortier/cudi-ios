//
//  CreateUserDTO.swift
//  ios-cudi
//
//  Created by Ben Fortier on 12/29/23.
//

import Foundation

struct CreateUserDTO: Equatable, Sendable, Encodable {
    let userID = UUID().uuidString
    let name: String
    let email: String
    let createdAt: Date = .now
    let password: String
    let cudiRelationship: CudiRelationship
    let favoritePartAboutCudi: String
}
