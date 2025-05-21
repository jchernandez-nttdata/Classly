//
//  LoadPayments.swift
//  PaymentsManagement
//
//  Created by Juan Carlos Hernandez Castillo on 21/05/25.
//

import Foundation

protocol LoadPayments {
    func execute() async throws(PaymentsManagementListError) -> [Payment]
}

final class LoadPaymentsImpl: LoadPayments {
    private let repository: PaymentsRepository

    init(repository: PaymentsRepository) {
        self.repository = repository
    }

    func execute() async throws(PaymentsManagementListError) -> [Payment] {
        return try await repository.loadPayments()
    }
}
