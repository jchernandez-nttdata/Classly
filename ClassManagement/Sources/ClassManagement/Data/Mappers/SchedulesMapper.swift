//
//  SchedulesMapper.swift
//  ClassManagement
//
//  Created by Juan Carlos Hernandez Castillo on 15/05/25.
//

class SchedulesMapper {
    private static func mapToClassSchedule(response: LoadClassSchedulesByLocationResponse) -> ClassSchedule {
        return ClassSchedule(
            id: response.id,
            dayOfWeek: DayOfWeek(rawValue: response.dayOfWeek) ?? .sunday,
            startTime: response.startTime,
            endTime: response.endTime,
            className: response.className,
            locationName: response.locationName
        )
    }

    static func mapToClassSchedules(responses: [LoadClassSchedulesByLocationResponse]) -> [ClassSchedule] {
        return responses.map(mapToClassSchedule)
    }

    private static func mapToEnrolledStudent(response: LoadEnrolledStudentsByScheduleResponse) -> EnrolledStudent {
        return EnrolledStudent(
            id: response.id,
            name: response.name,
            email: response.email,
            dni: response.dni,
            phone: response.phone,
            remainingClasses: response.remainingClasses
        )
    }

    static func mapToEnrolledStudents(responses: [LoadEnrolledStudentsByScheduleResponse]) -> [EnrolledStudent] {
        return responses.map(mapToEnrolledStudent)
    }
}
