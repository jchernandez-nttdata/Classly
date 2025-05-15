//
//  DayOfWeek.swift
//  ClassManagement
//
//  Created by Juan Carlos Hernandez Castillo on 14/05/25.
//

import Foundation

public enum DayOfWeek: Int, CaseIterable, Sendable {
    case monday = 1
    case tuesday = 2
    case wednesday = 3
    case thursday = 4
    case friday = 5
    case saturday = 6
    case sunday = 7
    
    var description: String {
        switch self {
        case .monday:
            return "Monday"
        case .tuesday:
            return "Tuesday"
        case .wednesday:
            return "Wednesday"
        case .thursday:
            return "Thursday"
        case .friday:
            return "Friday"
        case .saturday:
            return "Saturday"
        case .sunday:
            return "Sunday"
        }
    }
}
