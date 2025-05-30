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
}
