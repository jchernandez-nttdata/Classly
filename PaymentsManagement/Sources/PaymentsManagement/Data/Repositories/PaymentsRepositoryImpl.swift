//
//  PaymentsRepositoryImpl.swift
//  PaymentsManagement
//
//  Created by Juan Carlos Hernandez Castillo on 21/05/25.
//

class PaymentsRepositoryImpl: PaymentsRepository {

    private let remoteDataSource: PaymentsDataSource

    init(remoteDataSource: PaymentsDataSource) {
        self.remoteDataSource = remoteDataSource
    }

    func loadPayments() async throws(PaymentsManagementListError) -> [Payment] {
        do {
            return try await remoteDataSource.loadPayments()
        } catch let error as PaymentsManagementListError {
            throw error
        } catch {
            throw .serverError
        }
    }

    func loadLocations() async throws(PaymentsManagementListError) -> [SelectableLocation] {
        do {
            return try await remoteDataSource.loadLocations()
        } catch let error as PaymentsManagementListError {
            throw error
        } catch {
            throw .serverError
        }
    }

    func loadClasses(locationId: Int) async throws(PaymentsManagementListError) -> [SelectableClass] {
        do {
            return try await remoteDataSource.loadClasses(locationId: locationId)
        } catch let error as PaymentsManagementListError {
            throw error
        } catch {
            throw .serverError
        }
    }
}
