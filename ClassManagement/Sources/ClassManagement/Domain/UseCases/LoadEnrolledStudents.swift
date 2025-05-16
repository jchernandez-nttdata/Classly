//
//  LoadClassSchedulesByLocation.swift
//  ClassManagement
//
//  Created by Juan Carlos Hernandez Castillo on 15/05/25.
//

import Core
import Foundation

protocol LoadClassSchedulesByLocation {
    func execute(locationId: Int) async throws(LoadClassSchedulesError) -> [ClassSchedule]
}

final class LoadClassSchedulesByLocationImpl: LoadClassSchedulesByLocation {
    private let repository: SchedulesRepository

    struct Request {
        let locationId: Int
    }

    init(repository: SchedulesRepository) {
        self.repository = repository
    }

    func execute(locationId: Int) async throws(LoadClassSchedulesError) -> [ClassSchedule] {
        return try await repository.loadClassScheduleByLocationId(locationId: locationId)
    }
}
