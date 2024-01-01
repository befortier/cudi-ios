//
//  UserDTO.swift
//  ios-cudi
//
//  Created by Ben Fortier on 12/27/23.
//

import Foundation

struct UserDTO: DecodedDTO {
    let id: String
    let name: String
    let email: String
    let createdAt: Date
    let relationshipToCudi: CudiRelationship
    let favoritePartAboutCudi: String
}
