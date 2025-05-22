//
//  PaymentsRepository.swift
//  PaymentsManagement
//
//  Created by Juan Carlos Hernandez Castillo on 21/05/25.
//

protocol PaymentsRepository {
    func loadPayments() async throws(PaymentsManagementListError) -> [Payment]
    func loadLocations() async throws(PaymentsManagementListError) -> [SelectableLocation]
    func loadClasses(locationId: Int) async throws(PaymentsManagementListError) -> [SelectableClass]
}
