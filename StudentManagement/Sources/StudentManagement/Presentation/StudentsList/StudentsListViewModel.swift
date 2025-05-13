//
//  StudentsListViewModel.swift
//  StudentManagement
//
//  Created by Juan Carlos Hernandez Castillo on 7/05/25.
//

import Foundation
import Core

@MainActor
final class StudentsListViewModel: ObservableObject {
    @Published public var students: [Student] = []
    @Published public var isLoading = false

    private let coordinator: (any CoordinatorProtocol)?
    private let loadStudentsUseCase: LoadStudentsUseCase?

    init(
        coordinator: (any CoordinatorProtocol)? = nil,
        loadStudentsUseCase: LoadStudentsUseCase? = nil
    ) {
        self.coordinator = coordinator
        self.loadStudentsUseCase = loadStudentsUseCase
    }

    func loadStudents() {
        guard let loadStudentsUseCase else { return }

        Task {
            isLoading = true

            // simulates loading
            try await Task.sleep(nanoseconds: 1_500_000_000)

            do throws(LoadStudentsError) {
                students = try await loadStudentsUseCase.execute()
            } catch {
                switch error {
                case .invalidData:
                    print("invalidData")
                case .networkError:
                    print("networkError")
                case .serverError:
                    print("serverError")
                case .requestError:
                    print("requestError")
                }
            }

            isLoading = false
        }
    }

    func toManageStudent(_ student: Student?) {
        guard let coordinator = coordinator as? StudentManagementCoordinator else { return }
        coordinator.push(.manageStudent(student))
    }
}
