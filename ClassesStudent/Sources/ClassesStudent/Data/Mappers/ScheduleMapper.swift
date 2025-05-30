//
//  File.swift
//  ClassesStudent
//
//  Created by Juan Carlos Hernandez Castillo on 29/05/25.
//

import Core

enum ScheduleMapper {
    private static func mapToStudentClass(response: StudentClassResponse) -> StudentClass {
        return StudentClass(
            userScheduleId: response.userScheduleId,
            className: response.className,
            locationName: response.locationName,
            dayOfWeek: DayOfWeek(rawValue: response.dayOfWeek) ?? .sunday,
            startTime: response.startTime,
            endTime: response.endTime,
            attendanceRecorded: response.attendanceRecorded,
            remainingClasses: response.remainingClasses
        )
    }

    static func mapToStudentClasses(responses: [StudentClassResponse]) -> [StudentClass] {
        return responses.map(mapToStudentClass)
    }
}
