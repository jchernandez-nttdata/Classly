//
//  File.swift
//  Authentication
//
//  Created by Juan Carlos Hernandez Castillo on 29/04/25.
//

import Core

class LoginResponseMapper {
    static func mapToUser(response: LoginResponse) -> User {
        return User(
            id: response.id,
            name: response.name,
            email: response.email,
            dni: response.dni,
            phone: response.phone,
            role: UserRole(rawValue: response.role)!
        )
    }
}
