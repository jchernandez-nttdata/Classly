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
    private let addStudentsUseCase: AddStudentUseCase?

    init(
        coordinator: (any CoordinatorProtocol)? = nil,
        addStudent: AddStudentUseCase? = nil,
        existingStudent: Student? = nil
    ) {
        self.coordinator = coordinator
        self.existingStudent = existingStudent
        self.addStudentsUseCase = addStudent

        if let existingStudent {
            initEditStudent(existingStudent)
        }
    }

    private func initEditStudent(_ student: Student) {
        if let date = student.birthdate {
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

    func save() {
        let isEdit = existingStudent != nil

        if isEdit {

        } else {
            addStudent()
        }
    }

    private func addStudent() {
        guard let addStudentsUseCase else { return }

        Task {
            isLoading = true

            // simulates loading
            try await Task.sleep(nanoseconds: 1_500_000_000)

            do throws(AddStudentError) {
                try await addStudentsUseCase.execute(
                    request: AddStudentUseCaseImpl.AddStudentRequest(
                        name: name,
                        email: email,
                        dni: dni,
                        phone: phone,
                        password: password,
                        birthdate: birthDate
                    )
                )

                // TODO: show success toast
                goBack()
            } catch {
                switch error {
                case .invalidData:
                    print("invalidData")
                case .duplicateStudent:
                    print("duplicate student")
                default:
                    print("error general")
                }
            }

            isLoading = false
        }
    }
}
