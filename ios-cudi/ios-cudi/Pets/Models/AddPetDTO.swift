//
//  AddPetDTO.swift
//  ios-cudi
//
//  Created by Ben Fortier on 12/30/23.
//

import Foundation

protocol EncodedDTO: Encodable, Sendable {}

struct AddPetDTO: EncodedDTO {
    let name: String
    let type: PetType
    let birthdate: Date
    let avatar: Data?
}
