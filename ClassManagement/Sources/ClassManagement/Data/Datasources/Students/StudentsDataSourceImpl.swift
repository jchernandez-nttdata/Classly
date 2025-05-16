//
//  StudentsDataSourceImpl.swift
//  ClassManagement
//
//  Created by Juan Carlos Hernandez Castillo on 16/05/25.
//

import ClasslyNetworking
import Core

final class StudentsDataSourceImpl: StudentsDataSource {

    private let networkingManager: NetworkManagerProtocol

    init(networkingManager: NetworkManagerProtocol) {
        self.networkingManager = networkingManager
    }

    func loadStudentsQuery(query: String) async throws -> [Student] {
        do {
            let request = LoadStudentsQueryApiRequest(query: query)
            let response = try await networkingManager.performRequest(request)
            return StudentMapper.mapToStudents(responses: response)
        } catch {
            throw ClassManagementNetworkErrorMapper.toClassManagementListError(error)
        }
    }
}
