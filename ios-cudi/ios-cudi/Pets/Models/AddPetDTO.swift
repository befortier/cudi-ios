//
//  AddPetDTO.swift
//  ios-cudi
//
//  Created by Ben Fortier on 12/30/23.
//

import Foundation

struct AddPetDTO: Encodable {
    let name: String
    let type: PetType
    let birthdate: Date
    let avatar: Data?
}
