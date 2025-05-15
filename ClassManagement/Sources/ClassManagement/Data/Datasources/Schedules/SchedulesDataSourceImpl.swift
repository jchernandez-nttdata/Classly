//
//  SchedulesDataSourceImpl.swift
//  ClassManagement
//
//  Created by Juan Carlos Hernandez Castillo on 15/05/25.
//

import ClasslyNetworking

final class SchedulesDataSourceImpl: SchedulesDataSource {

    private let networkingManager: NetworkManagerProtocol

    init(networkingManager: NetworkManagerProtocol) {
        self.networkingManager = networkingManager
    }

    func loadClassScheduleByLocationId(locationId: Int) async throws -> [ClassSchedule] {
        do {
            let request = LoadClassSchedulesByLocationApiRequest(locationId: locationId)
            let response = try await networkingManager.performRequest(request)
            return SchedulesMapper.mapToClassSchedules(responses: response)
        } catch {
            throw ClassManagementNetworkErrorMapper.toLoadClassScheduleError(error)
        }
    }

}
