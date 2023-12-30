//
//  PetServiceAPIClient.swift
//  ios-cudi
//
//  Created by Ben Fortier on 12/29/23.
//

import Foundation

struct PetServiceAPIClient {
    let httpClient = NetworkServiceImpl()

    func addPet() async throws {
        
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
}

struct GetPetsEndpoint: Endpoint {
    var path: String = ""

    var queryParameters: [String : String]? { nil }

    var headers: [String : String]? { nil }

}
