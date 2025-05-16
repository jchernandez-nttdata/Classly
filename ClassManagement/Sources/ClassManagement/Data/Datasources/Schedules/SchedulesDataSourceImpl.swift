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
            throw ClassManagementNetworkErrorMapper.toClassManagementListError(error)
        }
    }

    func loadEnrolledStudentsByScheduleId(scheduleId: Int) async throws -> [EnrolledStudent] {
        do {
            let request = LoadEnrolledStudentsByScheduleApiRequest(scheduleId: scheduleId)
            let response = try await networkingManager.performRequest(request)
            return SchedulesMapper.mapToEnrolledStudents(responses: response)
        } catch {
            throw ClassManagementNetworkErrorMapper.toClassManagementListError(error)
        }
    }
}
