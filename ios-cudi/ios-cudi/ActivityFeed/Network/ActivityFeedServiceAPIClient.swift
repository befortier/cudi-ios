//
//  ActivityFeedServiceAPIClient.swift
//  ios-cudi
//
//  Created by Ben Fortier on 12/31/23.
//

import Foundation

struct ActivityFeedServiceAPIClient {
    let httpClient = NetworkServiceImpl()

    func getActivityHome() async throws -> [ActivityFeedItemDTO] {
        []
    }
}

struct GetActivityFeedHome: GetEndpoint {
    var path: String = ""

    var queryParameters: [String : String]? { nil }

    var headers: [String : String]? { nil }

}
