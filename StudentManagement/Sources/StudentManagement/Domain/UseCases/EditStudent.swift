//
//  EditStudent.swift
//  StudentManagement
//
//  Created by Juan Carlos Hernandez Castillo on 13/05/25.
//

import Core
import Foundation

protocol EditStudent {
    func execute(request: EditStudentImpl.EditStudentRequest) async throws(ManageStudentError)
}

final class EditStudentImpl: EditStudent {
    private let repository: StudentsRepository

    struct EditStudentRequest {
        let id: Int
        let name: String
        let email: String
        let dni: String
        let phone: String
        let password: String
        let birthdate: Date
    }

    init(repository: StudentsRepository) {
        self.repository = repository
    }

    func execute(request: EditStudentImpl.EditStudentRequest) async throws(ManageStudentError) {
        try await repository.editStudent(request: request)
    }
}
