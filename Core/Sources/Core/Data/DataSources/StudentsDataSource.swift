//
//  StudentsDataSource.swift
//  Core
//
//  Created by Juan Carlos Hernandez Castillo on 21/05/25.
//

public protocol StudentsDataSource: Sendable {
    func loadStudentsQuery(query: String) async throws -> [Student]
}
