//
//  LoadStudentsQueryApiRequest.swift
//  Core
//
//  Created by Juan Carlos Hernandez Castillo on 21/05/25.
//

import ClasslyNetworking

struct LoadStudentsQueryApiRequest: Request {
    typealias Response = [LoadStudentsQueryResponse]

    var urlMethod: HTTPMethod = .GET
    var endpoint: String = "/users/students"
    var params: [String: String]?

    init(query: String) {
        self.params = ["search": query]
    }
}

struct LoadStudentsQueryResponse: Decodable {
    let id: Int
    let name: String
    let email: String
    let dni: String
    let phone: String
    let role: String
    let birthdate: String
}
