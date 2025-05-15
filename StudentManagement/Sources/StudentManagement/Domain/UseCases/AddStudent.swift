//
//  AddStudent.swift
//  StudentManagement
//
//  Created by Juan Carlos Hernandez Castillo on 13/05/25.
//

import Core
import Foundation

protocol AddStudent {
    func execute(request: AddStudentImpl.AddStudentRequest) async throws(ManageStudentError)
}

final class AddStudentImpl: AddStudent {
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

    func execute(request: AddStudentImpl.AddStudentRequest) async throws(ManageStudentError) {
        try await repository.addStudent(request: request)
    }
}
