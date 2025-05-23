//
//  PaymentsManagementDIContainer.swift
//  PaymentsManagement
//
//  Created by Juan Carlos Hernandez Castillo on 21/05/25.
//

import ClasslyNetworking
import Core

public final class PaymentsManagementDIContainer {

    public init() { }

    // MARK: - Network
    private lazy var networkManager = NetworkManager()

    // MARK: - Datasources
    private lazy var paymentsDS = PaymentsDataSourceImpl(networkingManager: networkManager)
    private lazy var studentsDS = StudentsDataSourceImpl(networkingManager: networkManager)

    // MARK: - Repositories
    private lazy var paymentsRepo = PaymentsRepositoryImpl(remoteDataSource: paymentsDS)
    private lazy var studentsRepo = StudentsRepositoryImpl(remoteDataSource: studentsDS)

    // MARK: - Use cases
    lazy var loadPayments: LoadPayments = LoadPaymentsImpl(repository: paymentsRepo)
    lazy var loadStudentsQuery: LoadStudentsQuery = LoadStudentsQueryImpl(repository: studentsRepo)
    lazy var loadLocations: LoadSelectableLocations = LoadSelectableLocationsImpl(repository: paymentsRepo)
    lazy var loadClasses: LoadSelectableClasses = LoadSelectableClassesImpl(repository: paymentsRepo)
    lazy var loadSchedules: LoadSelectableSchedules = LoadSelectableSchedulesImpl(repository: paymentsRepo)
    lazy var addPayment: AddPayment = AddPaymentImpl(repository: paymentsRepo)
}
