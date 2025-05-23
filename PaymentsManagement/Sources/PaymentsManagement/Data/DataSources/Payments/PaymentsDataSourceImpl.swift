//
//  PaymentsDataSourceImpl.swift
//  PaymentsManagement
//
//  Created by Juan Carlos Hernandez Castillo on 21/05/25.
//

import ClasslyNetworking

final class PaymentsDataSourceImpl: PaymentsDataSource {
    
    private let networkingManager: NetworkManagerProtocol
    
    init(networkingManager: NetworkManagerProtocol) {
        self.networkingManager = networkingManager
    }
    
    func loadPayments() async throws -> [Payment] {
        do {
            let request = LoadPaymentsApiRequest()
            let response = try await networkingManager.performRequest(request)
            return PaymentsMapper.mapToPayments(responses: response)
        } catch {
            throw PaymentsManagementErrorMapper.toPaymentsManagementListError(error)
        }
    }

    func loadLocations() async throws -> [SelectableLocation] {
        do {
            let request = LoadSelectableLocationsApiRequest()
            let response = try await networkingManager.performRequest(request)
            return PaymentsMapper.mapToSelectableLocations(responses: response)
        } catch {
            throw PaymentsManagementErrorMapper.toPaymentsManagementListError(error)
        }
    }

    func loadClasses(locationId: Int) async throws -> [SelectableClass] {
        do {
            let request = LoadSelectableClassesApiRequest(locationId: locationId)
            let response = try await networkingManager.performRequest(request)
            return PaymentsMapper.mapToSelectableClasses(responses: response)
        } catch {
            throw PaymentsManagementErrorMapper.toPaymentsManagementListError(error)
        }
    }

    func loadSchedules(classId: Int) async throws -> [SelectableSchedule] {
        do {
            let request = LoadSelectableSchedulesApiRequest(classId: classId)
            let response = try await networkingManager.performRequest(request)
            return PaymentsMapper.mapToSelectableSchedules(responses: response)
        } catch {
            throw PaymentsManagementErrorMapper.toPaymentsManagementListError(error)
        }
    }

    func addPayment(params: AddPaymentImpl.Params) async throws {
        do {
            let request = AddPaymentApiRequest(from: params)
            let _ = try await networkingManager.performRequest(request)
            return
        } catch {
            throw PaymentsManagementErrorMapper.toAddPaymentError(error)
        }
    }
}
