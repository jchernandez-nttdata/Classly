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
            className: response.className
        )
    }

    static func mapToClassSchedules(responses: [LoadClassSchedulesByLocationResponse]) -> [ClassSchedule] {
        return responses.map(mapToClassSchedule)
    }
}
