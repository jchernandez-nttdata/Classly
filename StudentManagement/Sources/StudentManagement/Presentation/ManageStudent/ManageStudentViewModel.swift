//
//  ManageStudentViewModel.swift
//  StudentManagement
//
//  Created by Juan Carlos Hernandez Castillo on 13/05/25.
//

import Foundation
import Core

@MainActor
final class ManageStudentViewModel: ObservableObject {
    @Published public var isLoading = false
    @Published public var birthDate: Date = Date.now
    @Published public var name: String = ""
    @Published public var email: String = ""
    @Published public var dni: String = ""
    @Published public var phone: String = ""
    @Published public var password: String = ""

    var existingStudent: Student?

    private let coordinator: (any CoordinatorProtocol)?

    init(
        coordinator: (any CoordinatorProtocol)? = nil,
        existingStudent: Student? = nil
    ) {
        self.coordinator = coordinator
        self.existingStudent = existingStudent

        if let existingStudent {
            initEditStudent(existingStudent)
        }
    }

    private func initEditStudent(_ student: Student) {
        if let date = student.birthDate {
            birthDate = date
        }
        name = student.name
        email = student.email
        dni = student.dni
        phone = student.phone
    }

    func goBack() {
        coordinator?.pop()
    }
}
