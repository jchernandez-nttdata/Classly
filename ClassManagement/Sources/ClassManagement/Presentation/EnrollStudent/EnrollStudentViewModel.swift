//
//  EnrollStudentViewModel.swift
//  ClassManagement
//
//  Created by Juan Carlos Hernandez Castillo on 13/05/25.
//

import Foundation
import Core

@MainActor
final class EnrollStudentViewModel: ObservableObject {
    @Published public var isLoading = false
    @Published var searchResults: [Student] = []
    @Published var selectedStudentString: String = ""

    var schedule: ClassSchedule

    private let coordinator: (any CoordinatorProtocol)?
    private let toastManager: ToastManager
    private let loadStudentsQuery: LoadStudentsQuery?

    init(
        coordinator: (any CoordinatorProtocol)? = nil,
        schedule: ClassSchedule,
        toastManager: ToastManager = .shared,
        loadStudentsQuery: LoadStudentsQuery? = nil
    ) {
        self.coordinator = coordinator
        self.schedule = schedule
        self.toastManager = toastManager
        self.loadStudentsQuery = loadStudentsQuery
    }

    func goBack() {
        coordinator?.pop()
    }

    func searchStudentNames(query: String) async -> [String] {
        guard let safeUseCase = loadStudentsQuery else { return [] }
        do {
            let students = try await safeUseCase.execute(query: query)
            return students.map { $0.name }
        } catch {
            return []
        }
    }
}
