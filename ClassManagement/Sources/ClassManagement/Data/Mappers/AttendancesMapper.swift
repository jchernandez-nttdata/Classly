//
//  AttendancesMapper.swift
//  ClassManagement
//
//  Created by Juan Carlos Hernandez Castillo on 19/05/25.
//

class AttendancesMapper {
    private static func mapToStudentAttendance(response: LoadStudentAttendancesResponse) -> StudentAttendance {
        return StudentAttendance(
            studentId: response.studentId,
            name: response.name,
            registrationDate: response.registrationDate.toDate(format: .iso8601) ?? .now
        )
    }

    static func mapToStudentAttendances(responses: [LoadStudentAttendancesResponse]) -> [StudentAttendance] {
        return responses.map(mapToStudentAttendance)
    }
}
