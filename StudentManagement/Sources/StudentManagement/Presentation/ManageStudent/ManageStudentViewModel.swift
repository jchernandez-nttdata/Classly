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
    private let toastManager: ToastManager

    init(
        coordinator: (any CoordinatorProtocol)? = nil,
        addStudent: AddStudentUseCase? = nil,
        existingStudent: Student? = nil,
        toastManager: ToastManager = .shared
    ) {
        self.coordinator = coordinator
        self.existingStudent = existingStudent
        self.addStudentsUseCase = addStudent
        self.toastManager = toastManager

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

                toastManager.showToast(message: "User added successfully", type: .success)
                goBack()
            } catch {
                switch error {
                case .invalidData:
                    toastManager.showToast(message: "The data you entered is invalid", type: .error)
                case .duplicateStudent:
                    toastManager.showToast(message: "A student with this DNI or email already exists", type: .error)
                default:
                    toastManager.showToast(message: "An unexpected error occurred", type: .error)
                }
            }

            isLoading = false
        }
    }
}
