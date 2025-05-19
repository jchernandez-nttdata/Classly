//
//  LoadAttendancesDates.swift
//  ClassManagement
//
//  Created by Juan Carlos Hernandez Castillo on 19/05/25.
//

import Core
import Foundation

protocol LoadAttendancesDates {
    func execute(scheduleId: Int) async throws(ClassManagementListError) -> [String]
}

final class LoadAttendancesDatesImpl: LoadAttendancesDates {
    private let repository: AttendancesRepository

    init(repository: AttendancesRepository) {
        self.repository = repository
    }

    func execute(scheduleId: Int) async throws(ClassManagementListError) -> [String] {
        return try await repository.loadAttendancesDates(scheduleId: scheduleId)
    }
}
