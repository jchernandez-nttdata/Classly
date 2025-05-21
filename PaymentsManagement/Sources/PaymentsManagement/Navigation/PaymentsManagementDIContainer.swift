//
//  PaymentsManagementDIContainer.swift
//  PaymentsManagement
//
//  Created by Juan Carlos Hernandez Castillo on 21/05/25.
//

import ClasslyNetworking

public final class PaymentsManagementDIContainer {

    public init() { }

    // MARK: - Network
    private lazy var networkManager = NetworkManager()

    // MARK: - Datasources
    private lazy var paymentsDS = PaymentsDataSourceImpl(networkingManager: networkManager)

    // MARK: - Repositories
    private lazy var paymentsRepo = PaymentsRepositoryImpl(remoteDataSource: paymentsDS)

    // MARK: - Use cases
    lazy var loadPayments: LoadPayments = LoadPaymentsImpl(repository: paymentsRepo)
}
