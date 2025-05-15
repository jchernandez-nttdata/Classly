//
//  LoadStudents.swift
//  StudentManagement
//
//  Created by Juan Carlos Hernandez Castillo on 7/05/25.
//

import Core

protocol LoadStudents {
    func execute() async throws(LoadStudentsError) -> [Student]
}

final class LoadStudentsImpl: LoadStudents {
    private let repository: StudentsRepository

    init(repository: StudentsRepository) {
        self.repository = repository
    }

    func execute() async throws(LoadStudentsError) -> [Student] {
        return try await repository.loadStudents()
    }
}
