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
    static let brisco = PetDTO(id: "some-id-1", name: "Brisco", type: .dog, birthdate: .now, avatarURL: .init(string: "https://hips.hearstapps.com/hmg-prod/images/dog-puppy-on-garden-royalty-free-image-1586966191.jpg?crop=0.752xw:1.00xh;0.175xw,0&resize=1200:*")!)
    static let gatto = PetDTO(id: "some-id2", name: "Gatto", type: .cat, birthdate: .now, avatarURL: nil)
    static let brodie = PetDTO(id: "some-id3", name: "Brodie", type: .dog, birthdate: .now, avatarURL: nil)

    static let new = PetDTO(id: "some-id4", name: "New", type: .cat, birthdate: .now, avatarURL: nil)
}
