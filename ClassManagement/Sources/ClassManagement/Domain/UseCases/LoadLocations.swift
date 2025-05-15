//
//  LoadLocations.swift
//  ClassManagement
//
//  Created by Juan Carlos Hernandez Castillo on 14/05/25.
//

import Core

protocol LoadLocations {
    func execute() async throws(LoadLocationsError) -> [Location]
}

final class LoadLocationsImpl: LoadLocations {
    private let repository: LocationsRepository

    init(repository: LocationsRepository) {
        self.repository = repository
    }

    func execute() async throws(LoadLocationsError) -> [Location] {
        return try await repository.loadLocations()
    }
}
