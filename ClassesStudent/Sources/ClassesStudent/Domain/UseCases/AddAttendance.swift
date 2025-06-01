//
//  AddAttendance.swift
//  ClassesStudent
//
//  Created by Juan Carlos Hernandez Castillo on 1/06/25.
//

protocol AddAttendance: Sendable {
    func execute(userScheduleId: Int, QRLocationId: Int) async throws(AddAssistanceError)
}

final class AddAttendanceImpl: AddAttendance {
    private let repository: ScheduleRepository

    init(repository: ScheduleRepository) {
        self.repository = repository
    }

    func execute(userScheduleId: Int, QRLocationId: Int) async throws(AddAssistanceError) {
        return try await repository.addAttendance(userScheduleId: userScheduleId, locationId: QRLocationId)
    }
}
