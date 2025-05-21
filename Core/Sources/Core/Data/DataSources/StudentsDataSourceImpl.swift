//
//  StudentsDataSourceImpl.swift
//  Core
//
//  Created by Juan Carlos Hernandez Castillo on 21/05/25.
//

import ClasslyNetworking

public final class StudentsDataSourceImpl: StudentsDataSource {

    private let networkingManager: NetworkManagerProtocol

    public init(networkingManager: NetworkManagerProtocol) {
        self.networkingManager = networkingManager
    }

    public func loadStudentsQuery(query: String) async throws -> [Student] {
        do {
            let request = LoadStudentsQueryApiRequest(query: query)
            let response = try await networkingManager.performRequest(request)
            return StudentMapper.mapToStudents(responses: response)
        } catch {
            throw NetworkErrorMapper.toLoadListError(error)
        }
    }
}
