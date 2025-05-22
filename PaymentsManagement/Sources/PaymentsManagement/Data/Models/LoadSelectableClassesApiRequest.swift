//
//  LoadSelectableClassesApiRequest.swift
//  PaymentsManagement
//
//  Created by Juan Carlos Hernandez Castillo on 21/05/25.
//

import ClasslyNetworking

struct LoadSelectableClassesApiRequest: Request {
    typealias Response = [SelectableClassResponse]

    var urlMethod: HTTPMethod = .GET
    var endpoint: String { "/locations/\(locationId)/classes" }

    var locationId: Int
}

struct SelectableClassResponse: Decodable {
    let id: Int
    let className: String
}
