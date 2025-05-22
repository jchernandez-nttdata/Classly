//
//  LoadSelectableLocations.swift
//  PaymentsManagement
//
//  Created by Juan Carlos Hernandez Castillo on 21/05/25.
//

protocol LoadSelectableLocations {
    func execute() async throws(PaymentsManagementListError) -> [SelectableLocation]
}

final class LoadSelectableLocationsImpl: LoadSelectableLocations {
    private let repository: PaymentsRepository

    init(repository: PaymentsRepository) {
        self.repository = repository
    }

    func execute() async throws(PaymentsManagementListError) -> [SelectableLocation] {
        return try await repository.loadLocations()
    }
}
