//
//  AttendancesDataSourceImpl.swift
//  ClassManagement
//
//  Created by Juan Carlos Hernandez Castillo on 19/05/25.
//

import ClasslyNetworking

final class AttendancesDataSourceImpl: AttendancesDataSource {

    private let networkingManager: NetworkManagerProtocol
    
    init(networkingManager: NetworkManagerProtocol) {
        self.networkingManager = networkingManager
    }

    func loadAttendancesDates(scheduleId: Int) async throws -> [String] {
        do {
            let request = LoadAttendancesDatesApiRequest(scheduleId: scheduleId)
            return try await networkingManager.performRequest(request)
        } catch {
            throw ClassManagementNetworkErrorMapper.toClassManagementListError(error)
        }
    }
}
