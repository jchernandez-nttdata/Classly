//
//  LoadStudentAttendances.swift
//  ClassManagement
//
//  Created by Juan Carlos Hernandez Castillo on 19/05/25.
//

protocol LoadStudentAttendances {
    func execute(scheduleId: Int, date: String) async throws(ClassManagementListError) -> [StudentAttendance]
}

final class LoadStudentAttendancesImpl: LoadStudentAttendances {
    private let repository: AttendancesRepository

    init(repository: AttendancesRepository) {
        self.repository = repository
    }

    func execute(scheduleId: Int, date: String) async throws(ClassManagementListError) -> [StudentAttendance] {
        return try await repository.loadStudentAttendances(scheduleId: scheduleId, date: date)
    }
}
