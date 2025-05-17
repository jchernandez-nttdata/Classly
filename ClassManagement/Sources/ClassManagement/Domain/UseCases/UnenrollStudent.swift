//
//  File.swift
//  ClassManagement
//
//  Created by Juan Carlos Hernandez Castillo on 16/05/25.
//

protocol UnenrollStudent {
    func execute(studentId: Int, scheduleId: Int) async throws(UnenrollStudentError)
}

final class UnenrollStudentImpl: UnenrollStudent {
    private let repository: SchedulesRepository

    init(repository: SchedulesRepository) {
        self.repository = repository
    }

    func execute(studentId: Int, scheduleId: Int) async throws(UnenrollStudentError) {
        return try await repository.unenrollStudent(studentId: studentId, scheduleId: scheduleId)
    }
}
