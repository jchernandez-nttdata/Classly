//
//  Student.swift
//  StudentManagement
//
//  Created by Juan Carlos Hernandez Castillo on 6/05/25.
//

import Foundation

struct Student: Sendable, Identifiable {
    public let id: Int
    public let name: String
    public let email: String
    public let dni: String
    public let phone: String
    public let birthDate: Date?
}
