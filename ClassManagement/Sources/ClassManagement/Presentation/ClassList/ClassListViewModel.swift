//
//  ClassListViewModel.swift
//  ClassManagement
//
//  Created by Juan Carlos Hernandez Castillo on 14/05/25.
//

import Foundation
import Core
import Combine

@MainActor
final class ClassListViewModel: ObservableObject {
    // MARK: - Published state
    @Published public var locations: [Location] = []
    @Published public var classSchedules: [ClassSchedule] = []
    @Published public var selectedLocationString: String? = nil {
        didSet {
            loadClasses()
        }
    }
    @Published public var isLoading = false

    // MARK: - Dependencies
    private let coordinator: (any CoordinatorProtocol)?
    private let loadLocationsUseCase: LoadLocations?
    private let loadClassSchedulesByLocation: LoadClassSchedulesByLocation?
    private let toastManager: ToastManager

    // MARK: - Init
    init(
        coordinator: (any CoordinatorProtocol)? = nil,
        loadLocationsUseCase: LoadLocations? = nil,
        loadClassSchedulesByLocation: LoadClassSchedulesByLocation? = nil,
        toastManager: ToastManager = .shared
    ) {
        self.coordinator = coordinator
        self.loadLocationsUseCase = loadLocationsUseCase
        self.loadClassSchedulesByLocation = loadClassSchedulesByLocation
        self.toastManager = toastManager
    }

    func loadLocations() {
        guard let loadLocationsUseCase else { return }

        Task {
            isLoading = true

            // simulates loading
            try await Task.sleep(nanoseconds: 1_500_000_000)

            do {
                locations = try await loadLocationsUseCase.execute()

                guard let firstLocation = locations.first else { throw ClassManagementListError.noDataFound }
                selectedLocationString = firstLocation.name

            } catch let error as ClassManagementListError {
                mapErrorToToastMessage(error, notFoundErrorMessage: "No locations found")
            }
        }
    }

    func loadClasses() {
        guard let loadClassSchedulesByLocation else { return }
        guard let locationName = selectedLocationString,
              let location = locations.first(where: { $0.name == locationName }) else { return }

        Task {
            isLoading = true

            // simulates loading
            try await Task.sleep(nanoseconds: 1_500_000_000)

            do {
                classSchedules = try await loadClassSchedulesByLocation.execute(locationId: location.id)
                guard !classSchedules.isEmpty else { throw ClassManagementListError.noDataFound }

            } catch let error as ClassManagementListError {
                mapErrorToToastMessage(error, notFoundErrorMessage: "No classes found")
            }

            isLoading = false
        }
    }

    private func mapErrorToToastMessage(_ error: ClassManagementListError, notFoundErrorMessage: String = "") {
        switch error {
        case .noDataFound:
            toastManager.showToast(message: notFoundErrorMessage, type: .error)
        default:
            toastManager.showToast(message: "An unexpected error occurred", type: .error)
        }
    }

    func toScheduleDetail(_ schedule: ClassSchedule) {
        guard let coordinator = coordinator as? ClassManagementCoordinator else { return }
        coordinator.push(.scheduleDetail(schedule))
    }
}
