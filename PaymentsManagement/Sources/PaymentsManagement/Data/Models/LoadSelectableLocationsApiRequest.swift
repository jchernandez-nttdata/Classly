//
//  LoadSelectableLocationsApiRequest.swift
//  PaymentsManagement
//
//  Created by Juan Carlos Hernandez Castillo on 21/05/25.
//

import ClasslyNetworking

struct LoadSelectableLocationsApiRequest: Request {
    typealias Response = [SelectableLocationResponse]

    var urlMethod: HTTPMethod = .GET
    var endpoint: String = "/locations"

}

struct SelectableLocationResponse: Decodable {
    let id: Int
    let locationName: String
}
