//
//  StudentsDataSource.swift
//  ClassManagement
//
//  Created by Juan Carlos Hernandez Castillo on 16/05/25.
//

import Core

protocol StudentsDataSource: Sendable {
    func loadStudentsQuery(query: String) async throws -> [Student]
}
