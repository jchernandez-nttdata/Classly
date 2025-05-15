//
//  AddStudentApiRequest.swift
//  StudentManagement
//
//  Created by Juan Carlos Hernandez Castillo on 13/05/25.
//

import ClasslyNetworking
import Core

struct AddStudentApiRequest: RequestWithBody {
    typealias Response = NoResponse

    var urlMethod: HTTPMethod = .POST
    var endpoint: String = "/users"

    var body: AddStudentRequestBody

    init(from request: AddStudentImpl.AddStudentRequest) {
        self.body = AddStudentRequestBody(
            name: request.name,
            email: request.email,
            dni: request.dni,
            phone: request.phone,
            password: request.password,
            birthdate: request.birthdate.toString(),
            role: request.role.rawValue
        )
    }
}

struct AddStudentRequestBody: Codable {
    let name: String
    let email: String
    let dni: String
    let phone: String
    let password: String
    let birthdate: String
    let role: String
}
