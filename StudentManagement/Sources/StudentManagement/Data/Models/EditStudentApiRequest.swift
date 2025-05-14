//
//  EditStudentApiRequest.swift
//  StudentManagement
//
//  Created by Juan Carlos Hernandez Castillo on 13/05/25.
//

import ClasslyNetworking
import Core

struct EditStudentApiRequest: RequestWithBody {
    typealias Response = NoResponse

    var urlMethod: HTTPMethod = .PUT
    var endpoint: String { "/users/\(userId)" }

    var body: EditStudentRequestBody
    var userId: Int

    init(from request: EditStudentUseCaseImpl.EditStudentRequest) {
        self.userId = request.id
        self.body = EditStudentRequestBody(
            name: request.name,
            email: request.email,
            dni: request.dni,
            phone: request.phone,
            password: request.password,
            birthdate: request.birthdate.toString()
        )
    }
}

struct EditStudentRequestBody: Codable {
    let name: String
    let email: String
    let dni: String
    let phone: String
    let password: String
    let birthdate: String
}
