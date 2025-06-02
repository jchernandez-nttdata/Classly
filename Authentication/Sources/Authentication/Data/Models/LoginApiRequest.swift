//
//  File.swift
//  Authentication
//
//  Created by Juan Carlos Hernandez Castillo on 29/04/25.
//
import ClasslyNetworking

struct LoginApiRequest: RequestWithBody {
    typealias Response = LoginResponse

    var urlMethod: HTTPMethod = .POST
    var endpoint: String = "/auth/login"

    var body: LoginRequestBody

    init(email: String, password: String) {
        self.body = LoginRequestBody(email: email, password: password)
    }
}

struct LoginRequestBody: Codable {
    let email: String
    let password: String
}

struct LoginResponse: Decodable, Sendable {
    let id: Int
    let name: String
    let email: String
    let dni: String
    let password: String
    let phone: String
    let role: String
}


