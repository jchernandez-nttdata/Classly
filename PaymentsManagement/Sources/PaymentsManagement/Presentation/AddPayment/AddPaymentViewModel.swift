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
    @Published var locations: [SelectableLocation] = []
    @Published var selectedLocation: SelectableLocation?

    // MARK: - Dependencies
    private let coordinator: (any CoordinatorProtocol)?
    private let toastManager: ToastManager
    private let loadStudentsQuery: LoadStudentsQuery?
    private let loadSelectableLocationsUseCase: LoadSelectableLocations?

    // MARK: - Init
    init(
        coordinator: (any CoordinatorProtocol)? = nil,
        toastManager: ToastManager = .shared,
        loadStudentsQuery: LoadStudentsQuery? = nil,
        loadSelectableLocations: LoadSelectableLocations? = nil
    ) {
        self.coordinator = coordinator
        self.toastManager = toastManager
        self.loadStudentsQuery = loadStudentsQuery
        self.loadSelectableLocationsUseCase = loadSelectableLocations
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

    func loadSelectableLocations() {
        guard let loadSelectableLocationsUseCase else { return }

        Task {
            isLoading = true

            do throws(PaymentsManagementListError) {
                locations = try await loadSelectableLocationsUseCase.execute()
            } catch {
                switch error {

                default:
                    print("error \(error)")
                }
            }

            isLoading = false
        }
    }

    // MARK: - Coordinator methods

    func goBack() {
        coordinator?.pop()
    }
}
