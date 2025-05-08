//
//  LoadStudentsApiRequest.swift
//  StudentManagement
//
//  Created by Juan Carlos Hernandez Castillo on 7/05/25.
//

import ClasslyNetworking

struct LoadStudentsApiRequest: Request {
    typealias Response = [LoadStudentsResponse]

    var urlMethod: HTTPMethod = .GET
    var endpoint: String = "/users/students"
}

struct LoadStudentsResponse: Decodable {
    let id: Int
    let name: String
    let email: String
    let dni: String
    let phone: String
    let role: String
    let birthdate: String
}
