//
//  AddPaymentViewModel.swift
//  PaymentsManagement
//
//  Created by Juan Carlos Hernandez Castillo on 21/05/25.
//

import Foundation
import Core
import Combine

@MainActor
final class AddPaymentViewModel: ObservableObject {
    // MARK: - Published state
    @Published public var isLoading = false
    @Published var searchResults: [Student] = []
    @Published var selectedStudent: Student?
    @Published var locations: [SelectableLocation] = []
    @Published var selectedLocation: SelectableLocation?
    @Published var classes: [SelectableClass] = []
    @Published var selectedClass: SelectableClass?
    @Published var schedules: [SelectableSchedule] = []
    @Published var selectedSchedule: SelectableSchedule?

    private var cancellables = Set<AnyCancellable>()

    // MARK: - Dependencies
    private let coordinator: (any CoordinatorProtocol)?
    private let toastManager: ToastManager
    private let loadStudentsQuery: LoadStudentsQuery?
    private let loadSelectableLocationsUseCase: LoadSelectableLocations?
    private let loadSelectableClassesUseCase: LoadSelectableClasses?
    private let loadSelectableSchedulesUseCase: LoadSelectableSchedules?

    // MARK: - Init
    init(
        coordinator: (any CoordinatorProtocol)? = nil,
        toastManager: ToastManager = .shared,
        loadStudentsQuery: LoadStudentsQuery? = nil,
        loadSelectableLocations: LoadSelectableLocations? = nil,
        loadSelectableClasses: LoadSelectableClasses? = nil,
        loadSelectableSchedules: LoadSelectableSchedules? = nil
    ) {
        self.coordinator = coordinator
        self.toastManager = toastManager
        self.loadStudentsQuery = loadStudentsQuery
        self.loadSelectableLocationsUseCase = loadSelectableLocations
        self.loadSelectableClassesUseCase = loadSelectableClasses
        self.loadSelectableSchedulesUseCase = loadSelectableSchedules

        observeStateChanges()
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
                guard !locations.isEmpty else { throw .noDataFound }
            } catch {
                switch error {
                case .noDataFound:
                    toastManager.showToast(message: "No Locations Found", type: .error)
                default:
                    print("error \(error)")
                }
            }

            isLoading = false
        }
    }

    private func loadClasses(for location: SelectableLocation) {
        guard let loadSelectableClassesUseCase else { return }

        selectedClass = nil
        selectedSchedule = nil
        classes = []
        schedules = []

        Task {
            isLoading = true

            do throws(PaymentsManagementListError) {
                classes = try await loadSelectableClassesUseCase.execute(locationId: location.id)
                guard !classes.isEmpty else { throw .noDataFound }
            } catch {
                switch error {
                case .noDataFound:
                    toastManager.showToast(message: "No Classes Found", type: .error)
                default:
                    print("error \(error)")
                }
            }

            isLoading = false
        }
    }

    private func loadSchedules(for selectedClass: SelectableClass) {
        guard let loadSelectableSchedulesUseCase else { return }

        selectedSchedule = nil
        schedules = []

        Task {
            isLoading = true

            do throws(PaymentsManagementListError) {
                schedules = try await loadSelectableSchedulesUseCase.execute(classId: selectedClass.id)
                guard !schedules.isEmpty else { throw .noDataFound }
            } catch {
                switch error {
                case .noDataFound:
                    toastManager.showToast(message: "No Schedules Found", type: .error)
                default:
                    print("error \(error)")
                }
            }

            isLoading = false
        }
    }

    // MARK: - Private methods

    private func observeStateChanges() {
        $selectedLocation
            .dropFirst()
            .sink { [weak self] newLocation in
                guard let self, let location = newLocation else { return }
                self.loadClasses(for: location)
            }
            .store(in: &cancellables)

        $selectedClass
            .dropFirst()
            .sink { [weak self] newClass in
                guard let self, let selectedClass = newClass else { return }
                self.loadSchedules(for: selectedClass)
            }
            .store(in: &cancellables)
    }

    // MARK: - Coordinator methods

    func goBack() {
        coordinator?.pop()
    }
}
