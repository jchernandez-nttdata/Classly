//
//  Student.swift
//  StudentManagement
//
//  Created by Juan Carlos Hernandez Castillo on 6/05/25.
//

import Foundation

public struct Student: Sendable, Identifiable, Hashable {
    public let id: Int
    public let name: String
    public let email: String
    public let dni: String
    public let phone: String
    public let birthDate: Date?
}
