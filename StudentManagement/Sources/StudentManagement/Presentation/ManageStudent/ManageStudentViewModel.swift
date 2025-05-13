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

    var existingStudent: Student?

    private let coordinator: (any CoordinatorProtocol)?

    init(
        coordinator: (any CoordinatorProtocol)? = nil,
        existingStudent: Student? = nil
    ) {
        self.coordinator = coordinator
        self.existingStudent = existingStudent
    }

    func goBack() {
        coordinator?.pop()
    }
}
