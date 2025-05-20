//
//  ClassSchedule.swift
//  ClassManagement
//
//  Created by Juan Carlos Hernandez Castillo on 14/05/25.
//

import Foundation
import Core

public struct ClassSchedule: Sendable, Identifiable, Hashable {
    public let id: Int
    public let dayOfWeek: DayOfWeek
    public let startTime: String
    public let endTime: String
    public let className: String
    public let locationName: String
}
