//
//  ScheduleDataSourceImpl.swift
//  ClassesStudent
//
//  Created by Juan Carlos Hernandez Castillo on 29/05/25.
//

import ClasslyNetworking

final class ScheduleDataSourceImpl: ScheduleDataSource {
    
    private let networkingManager: NetworkManagerProtocol
    
    init(networkingManager: NetworkManagerProtocol) {
        self.networkingManager = networkingManager
    }
    
    func loadStudentClasses(studentId: Int) async throws -> [StudentClass] {
        do {
            let request = LoadStudentClassesApiRequest(studentId: studentId)
            let response = try await networkingManager.performRequest(request)
            return ScheduleMapper.mapToStudentClasses(responses: response)
        } catch {
            throw ClassesStudentErrorMapper.toClassStudentListError(error)
        }
    }

    func addAttendance(userScheduleId: Int, locationId: Int) async throws {
        do {
            let request = AddAttendanceApiRequest(
                userScheduleId: userScheduleId,
                locationId: locationId
            )
            _ = try await networkingManager.performRequest(request)
            return
        } catch {
            throw ClassesStudentErrorMapper.toAddAttendanceError(error)
        }
    }
}
