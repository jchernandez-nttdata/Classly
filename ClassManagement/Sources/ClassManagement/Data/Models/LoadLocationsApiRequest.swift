//
//  File.swift
//  ClassManagement
//
//  Created by Juan Carlos Hernandez Castillo on 14/05/25.
//

import ClasslyNetworking

struct LoadLocationsApiRequest: Request {
    typealias Response = [LoadLocationsResponse]

    var urlMethod: HTTPMethod = .GET
    var endpoint: String = "/locations"

}

struct LoadLocationsResponse: Decodable {
    let id: Int
    let locationName: String
    let address: String
}
