//
//  Payment.swift
//  PaymentsManagement
//
//  Created by Juan Carlos Hernandez Castillo on 20/05/25.
//

import Foundation

struct Payment: Sendable, Identifiable, Hashable {
    public let id: Int
    public let studentName: String
    public let amount: Double
    public let paidClasses: Int
    public let paymentDate: Date?
}
