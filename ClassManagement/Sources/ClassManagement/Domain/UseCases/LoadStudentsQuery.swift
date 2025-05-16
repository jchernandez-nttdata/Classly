//
//  File.swift
//  ClassManagement
//
//  Created by Juan Carlos Hernandez Castillo on 16/05/25.
//

import Core

protocol LoadStudentsQuery: Sendable {
    func execute(query: String) async throws(ClassManagementListError) -> [Student]
}

final class LoadStudentsQueryImpl: LoadStudentsQuery {
    private let repository: StudentsRepository

    init(repository: StudentsRepository) {
        self.repository = repository
    }

    func execute(query: String) async throws(ClassManagementListError) -> [Student] {
        return try await repository.loadStudentsQuery(query: query)
    }
}
