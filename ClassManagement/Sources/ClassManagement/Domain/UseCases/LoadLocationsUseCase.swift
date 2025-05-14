//
//  LoadLocationsUseCase.swift
//  ClassManagement
//
//  Created by Juan Carlos Hernandez Castillo on 14/05/25.
//

import Core

protocol LoadLocationsUseCase {
    func execute() async throws(LoadLocationsError) -> [Location]
}

final class LoadLocationsUseCaseImpl: LoadLocationsUseCase {
    private let repository: LocationsRepository

    init(repository: LocationsRepository) {
        self.repository = repository
    }

    func execute() async throws(LoadLocationsError) -> [Location] {
        return try await repository.loadLocations()
    }
}
