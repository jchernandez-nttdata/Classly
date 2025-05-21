//
//  LoadStudentsQuery.swift
//  Core
//
//  Created by Juan Carlos Hernandez Castillo on 21/05/25.
//

public protocol LoadStudentsQuery: Sendable {
    func execute(query: String) async throws(LoadListError) -> [Student]
}

public final class LoadStudentsQueryImpl: LoadStudentsQuery {
    private let repository: StudentsRepository

    public init(repository: StudentsRepository) {
        self.repository = repository
    }

    public func execute(query: String) async throws(LoadListError) -> [Student] {
        return try await repository.loadStudentsQuery(query: query)
    }
}
