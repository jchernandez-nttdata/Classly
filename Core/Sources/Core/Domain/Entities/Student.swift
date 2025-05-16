//
//  File.swift
//  Core
//
//  Created by Juan Carlos Hernandez Castillo on 16/05/25.
//

import Foundation

public struct Student: Sendable, Identifiable, Hashable {
    public let id: Int
    public let name: String
    public let email: String
    public let dni: String
    public let phone: String
    public let birthdate: Date?

    public init(
        id: Int,
        name: String,
        email: String,
        dni: String,
        phone: String,
        birthdate: Date?
    ) {
        self.id = id
        self.name = name
        self.email = email
        self.dni = dni
        self.phone = phone
        self.birthdate = birthdate
    }
}
