//
//  AddStudentUseCase.swift
//  StudentManagement
//
//  Created by Juan Carlos Hernandez Castillo on 13/05/25.
//

import Core
import Foundation

protocol AddStudentUseCase {
    func execute(request: AddStudentUseCaseImpl.AddStudentRequest) async throws(ManageStudentError)
}

final class AddStudentUseCaseImpl: AddStudentUseCase {
    private let repository: StudentsRepository

    struct AddStudentRequest {
        let name: String
        let email: String
        let dni: String
        let phone: String
        let password: String
        let birthdate: Date
        let role: UserRole = .student
    }

    init(repository: StudentsRepository) {
        self.repository = repository
    }

    func execute(request: AddStudentUseCaseImpl.AddStudentRequest) async throws(ManageStudentError) {
        try await repository.addStudent(request: request)
    }
}
