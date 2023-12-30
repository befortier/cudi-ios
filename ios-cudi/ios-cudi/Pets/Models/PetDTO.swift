//
//  PetDTO.swift
//  ios-cudi
//
//  Created by Ben Fortier on 12/29/23.
//

import Foundation

struct PetDTO: Decodable, Identifiable {
    let id: String
    let name: String
    let type: PetType
    let birthdate: Date
    let avatarURL: URL?
}

extension PetDTO {
    static let cudi = PetDTO(id: "some-id", name: "Cudi", type: .dog, birthdate: .now, avatarURL: nil)
    static let brisco = PetDTO(id: "some-id-1", name: "Brisco", type: .dog, birthdate: .now, avatarURL: nil)
    static let gatto = PetDTO(id: "some-id2", name: "Gatto", type: .cat, birthdate: .now, avatarURL: nil)
    static let brodie = PetDTO(id: "some-id3", name: "Brodie", type: .dog, birthdate: .now, avatarURL: nil)
}
