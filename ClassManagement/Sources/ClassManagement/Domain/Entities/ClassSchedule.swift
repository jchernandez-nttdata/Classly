//
//  ClassSchedule.swift
//  ClassManagement
//
//  Created by Juan Carlos Hernandez Castillo on 14/05/25.
//

import Foundation

struct ClassSchedule: Sendable, Identifiable, Hashable {
    let id: Int
    let dayOfWeek: DayOfWeek
    let startTime: String
    let endTime: String
    let className: String
}
