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

                guard let firstLocation = locations.first else { throw LoadLocationsError.noLocationsFound }
                selectedLocationString = firstLocation.name

            } catch let error as LoadLocationsError {
                switch error {
                case .noLocationsFound:
                    toastManager.showToast(message: "No locations found", type: .error)
                default:
                    toastManager.showToast(message: "An unexpected error occurred", type: .error)
                }
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
                guard !classSchedules.isEmpty else { throw LoadClassSchedulesError.noClassSchedulesFound }

            } catch let error as LoadClassSchedulesError {
                switch error {
                case .noClassSchedulesFound:
                    toastManager.showToast(message: "No classes found", type: .error)
                default:
                    toastManager.showToast(message: "An unexpected error occurred", type: .error)
                }
            }

            isLoading = false
        }
    }
}
