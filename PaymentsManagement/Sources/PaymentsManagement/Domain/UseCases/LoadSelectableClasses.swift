//
//  LoadSelectableClasses.swift
//  PaymentsManagement
//
//  Created by Juan Carlos Hernandez Castillo on 21/05/25.
//

import Foundation

protocol LoadSelectableClasses {
    func execute(locationId: Int) async throws(PaymentsManagementListError) -> [SelectableClass]
}

final class LoadSelectableClassesImpl: LoadSelectableClasses {
    private let repository: PaymentsRepository

    init(repository: PaymentsRepository) {
        self.repository = repository
    }

    func execute(locationId: Int) async throws(PaymentsManagementListError) -> [SelectableClass] {
        return try await repository.loadClasses(locationId: locationId)
    }
}
