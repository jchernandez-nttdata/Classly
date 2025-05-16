//
//  LoadEnrolledStudentsBySchedule.swift
//  ClassManagement
//
//  Created by Juan Carlos Hernandez Castillo on 15/05/25.
//

import Core
import Foundation

protocol LoadEnrolledStudentsBySchedule {
    func execute(scheduleId: Int) async throws(ClassManagementListError) -> [EnrolledStudent]
}

final class LoadEnrolledStudentsByScheduleImpl: LoadEnrolledStudentsBySchedule {
    private let repository: SchedulesRepository

    init(repository: SchedulesRepository) {
        self.repository = repository
    }

    func execute(scheduleId: Int) async throws(ClassManagementListError) -> [EnrolledStudent] {
        return try await repository.loadEnrolledStudentsByScheduleId(scheduleId: scheduleId)
    }
}
