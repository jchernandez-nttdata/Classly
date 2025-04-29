//
//  User.swift
//  Authentication
//
//  Created by Juan Carlos Hernandez Castillo on 29/04/25.
//

import Core

struct User: Sendable {
    public let id: Int
    public let name: String
    public let email: String
    public let dni: String
    public let phone: String
    public let role: UserRole
}

