//
//  PetServiceAPIClient.swift
//  ios-cudi
//
//  Created by Ben Fortier on 12/29/23.
//

import Foundation

struct PetServiceAPIClient {
    let httpClient = NetworkServiceImpl()

    func addPet(addPetDTO: AddPetDTO) async throws -> PetDTO {
        PetDTO(id: "new-pet", name: addPetDTO.name, type: addPetDTO.type, birthdate: addPetDTO.birthdate, avatarURL: nil)
    }
    
    func removePet() async throws {
        
    }
    
    func getPets() async throws -> [PetDTO] {
        return [
            .cudi,
            .brisco,
            .brodie,
            .gatto
        ]
//        return try await httpClient.fetch(from: GetPetsEndpoint())
    }


    func getPets(for petIDs: [Pet.ID]) async throws -> [PetDTO] {
        return [
            .new
        ]
//        return try await httpClient.fetch(from: GetPetsEndpoint())
    }
}

struct GetPetsEndpoint: GetEndpoint {
    var path: String = ""

    var queryParameters: [String : String]? { nil }

    var headers: [String : String]? { nil }

}
