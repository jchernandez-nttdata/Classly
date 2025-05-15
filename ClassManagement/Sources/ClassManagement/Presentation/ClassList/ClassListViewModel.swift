//
//  ClassListViewModel.swift
//  ClassManagement
//
//  Created by Juan Carlos Hernandez Castillo on 14/05/25.
//

import Foundation
import Core

@MainActor
final class ClassListViewModel: ObservableObject {
    @Published public var locations: [Location] = []
    @Published public var selectedLocationString: String? = nil
    @Published public var isLoading = false

    private let coordinator: (any CoordinatorProtocol)?
    private let loadLocationsUseCase: LoadLocations?

    init(
        coordinator: (any CoordinatorProtocol)? = nil,
        loadLocationsUseCase: LoadLocations? = nil
    ) {
        self.coordinator = coordinator
        self.loadLocationsUseCase = loadLocationsUseCase
    }

    func loadLocations() {
        guard let loadLocationsUseCase else { return }

        Task {
            isLoading = true

            // simulates loading
            try await Task.sleep(nanoseconds: 1_500_000_000)

            do throws(LoadLocationsError) {
                locations = try await loadLocationsUseCase.execute()
                selectedLocationString = locations.first?.name
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
}
