//
//  LoadSelectableSchedules.swift
//  PaymentsManagement
//
//  Created by Juan Carlos Hernandez Castillo on 21/05/25.
//

import Foundation

protocol LoadSelectableSchedules {
    func execute(classId: Int) async throws(PaymentsManagementListError) -> [SelectableSchedule]
}

final class LoadSelectableSchedulesImpl: LoadSelectableSchedules {
    private let repository: PaymentsRepository

    init(repository: PaymentsRepository) {
        self.repository = repository
    }

    func execute(classId: Int) async throws(PaymentsManagementListError) -> [SelectableSchedule] {
        return try await repository.loadSchedules(classId: classId)
    }
}
