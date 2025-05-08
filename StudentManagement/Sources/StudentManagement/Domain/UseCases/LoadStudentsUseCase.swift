//
//  LoadStudentsUseCase.swift
//  StudentManagement
//
//  Created by Juan Carlos Hernandez Castillo on 7/05/25.
//

import Core

protocol LoadStudentsUseCase {
    func execute() async throws(LoadStudentsError) -> [Student]
}

final class LoadStudentsUseCaseImpl: LoadStudentsUseCase {
    private let repository: StudentsRepository

    init(repository: StudentsRepository) {
        self.repository = repository
    }

    func execute() async throws(LoadStudentsError) -> [Student] {
        return try await repository.loadStudents()
    }
}
