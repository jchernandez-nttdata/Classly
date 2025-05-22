//
//  AddPaymentViewModel.swift
//  PaymentsManagement
//
//  Created by Juan Carlos Hernandez Castillo on 21/05/25.
//

import Foundation
import Core

@MainActor
final class AddPaymentViewModel: ObservableObject {
    // MARK: - Published state
    @Published public var isLoading = false
    @Published var searchResults: [Student] = []
    @Published var selectedStudent: Student?

    // MARK: - Dependencies
    private let coordinator: (any CoordinatorProtocol)?
    private let toastManager: ToastManager
    private let loadStudentsQuery: LoadStudentsQuery?

    // MARK: - Init
    init(
        coordinator: (any CoordinatorProtocol)? = nil,
        toastManager: ToastManager = .shared,
        loadStudentsQuery: LoadStudentsQuery? = nil
    ) {
        self.coordinator = coordinator
        self.toastManager = toastManager
        self.loadStudentsQuery = loadStudentsQuery
    }

    // MARK: - Use cases

    func searchStudentNames(query: String) async -> [Student] {
        guard let safeUseCase = loadStudentsQuery else { return [] }
        do {
            searchResults = try await safeUseCase.execute(query: query)
            return searchResults
        } catch {
            return []
        }
    }

    // MARK: - Coordinator methods

    func goBack() {
        coordinator?.pop()
    }
}
