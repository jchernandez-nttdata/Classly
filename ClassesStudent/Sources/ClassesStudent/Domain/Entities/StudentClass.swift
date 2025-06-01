//
//  StudentClass.swift
//  ClassesStudent
//
//  Created by Juan Carlos Hernandez Castillo on 28/05/25.
//

import Foundation
import Core

public struct StudentClass: Identifiable, Sendable, Hashable{
    let userScheduleId: Int
    let className: String
    let locationName: String
    let dayOfWeek: DayOfWeek
    let startTime: String
    let endTime: String
    let attendanceRecorded: Bool
    let remainingClasses: Int

    public var id: Int { userScheduleId }
}


extension Array where Element == StudentClass {
    /// Groups student classes by their day of the week.
    ///
    /// - Returns: A dictionary where the keys are `DayOfWeek` values and the values are arrays of classes on that day.
    func groupedByDay() -> [DayOfWeek: [StudentClass]] {
        Dictionary(grouping: self) { $0.dayOfWeek }
    }

    /// Returns a sorted array of key-value pairs (DayOfWeek and its classes) ordered from Monday to Sunday.
    func sortedGroupedByDay() -> [(key: DayOfWeek, value: [StudentClass])] {
        groupedByDay().sorted { $0.key.rawValue < $1.key.rawValue }
    }
}
