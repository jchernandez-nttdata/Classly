//
//  StudentsRepository.swift
//  Core
//
//  Created by Juan Carlos Hernandez Castillo on 21/05/25.
//

public protocol StudentsRepository: Sendable {
    func loadStudentsQuery(query: String) async throws(LoadListError) -> [Student]
}
