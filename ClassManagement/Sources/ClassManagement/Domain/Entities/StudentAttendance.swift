//
//  StudentAttendance.swift
//  ClassManagement
//
//  Created by Juan Carlos Hernandez Castillo on 19/05/25.
//

import Foundation

public struct StudentAttendance: Sendable, Identifiable, Hashable {
    public var id: Int { studentId }
    public var studentId: Int
    public let name: String
    public let registrationDate: Date
}
