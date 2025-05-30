//
//  PaymentsDataSource.swift
//  PaymentsManagement
//
//  Created by Juan Carlos Hernandez Castillo on 21/05/25.
//

protocol PaymentsDataSource {
    func loadPayments() async throws -> [Payment]
    func loadLocations() async throws -> [SelectableLocation]
    func loadClasses(locationId: Int) async throws -> [SelectableClass]
    func loadSchedules(classId: Int) async throws -> [SelectableSchedule]
    func addPayment(params: AddPaymentImpl.Params) async throws
}
