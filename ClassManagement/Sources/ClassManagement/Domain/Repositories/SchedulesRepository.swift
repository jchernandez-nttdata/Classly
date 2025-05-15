//
//  ScheduleRepository.swift
//  ClassManagement
//
//  Created by Juan Carlos Hernandez Castillo on 15/05/25.
//

import Foundation

protocol SchedulesRepository {
    func loadClassScheduleByLocationId(locationId: Int) async throws(LoadClassSchedulesError) -> [ClassSchedule]
}
