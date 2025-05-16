//
//  ScheduleStudent.swift
//  ClassManagement
//
//  Created by Juan Carlos Hernandez Castillo on 15/05/25.
//

import Foundation

public struct ScheduleStudent: Sendable, Identifiable, Hashable {
    public let id: Int
    public let name: String
    public let email: String
    public let dni: String
    public let phone: String
    public let remainingClasses: Int
}
