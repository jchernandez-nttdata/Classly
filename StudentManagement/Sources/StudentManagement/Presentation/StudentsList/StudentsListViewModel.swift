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
    @Published public var searchText: String = ""

    var filteredStudents: [Student] {
        guard !searchText.isEmpty else { return students }

        let normalizedSearchText = searchText.folding(options: .diacriticInsensitive, locale: .current).lowercased()

        return students.filter { student in
            let normalizedName = student.name.folding(options: .diacriticInsensitive, locale: .current).lowercased()
            return normalizedName.contains(normalizedSearchText)
        }
    }


    private let coordinator: (any CoordinatorProtocol)?
    private let loadStudentsUseCase: LoadStudents?

    init(
        coordinator: (any CoordinatorProtocol)? = nil,
        loadStudentsUseCase: LoadStudents? = nil
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
