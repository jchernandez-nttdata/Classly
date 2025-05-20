//
//  Payment.swift
//  PaymentsManagement
//
//  Created by Juan Carlos Hernandez Castillo on 20/05/25.
//

import Foundation
import Core

struct Payment: Sendable, Identifiable, Hashable {
    public let id: Int
    public let studentName: String
    public let amount: Double
    public let paidClasses: Int
    public let paymentDate: Date?
    public let classInfo: ClassInfo
}

struct ClassInfo: Sendable, Hashable {
    public let locationName: String
    public let className: String
    public let schedule: Schedule
}

public struct Schedule: Sendable, Hashable {
    public let dayOfWeek: DayOfWeek
    public let startTime: String
    public let endTime: String
}
