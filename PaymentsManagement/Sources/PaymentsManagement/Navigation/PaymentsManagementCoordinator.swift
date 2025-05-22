//
//  PaymentManagementCoordinator.swift
//  PaymentsManagement
//
//  Created by Juan Carlos Hernandez Castillo on 20/05/25.
//

import SwiftUI
import ClasslyNetworking
import Core

public enum PaymentManagementRoute: Hashable {
    case paymentsList
    case addPayment
}

public final class PaymentsManagementCoordinator: CoordinatorProtocol {
    public typealias Route = PaymentManagementRoute
    public typealias Content = AnyView

    @Published public var path = NavigationPath()

    private let di: PaymentsManagementDIContainer

    public init(di: PaymentsManagementDIContainer) {
        self.di = di
    }

    public func build(route: PaymentManagementRoute) -> AnyView {
        switch route {
        case .paymentsList:
            let viewModel = PaymentsListViewModel(
                coordinator: self,
                loadPaymentsUseCase: di.loadPayments
            )
            return AnyView(PaymentsListView(viewModel: viewModel))
        case .addPayment:
            let viewModel = AddPaymentViewModel(
                coordinator: self,
                loadStudentsQuery: di.loadStudentsQuery,
                loadSelectableLocations: di.loadLocations,
                loadSelectableClasses: di.loadClasses,
                loadSelectableSchedules: di.loadSchedules
            )
            return AnyView(AddPaymentView(viewModel: viewModel))
        }
    }

    @ViewBuilder public func start() -> AnyView {
        AnyView(PaymentsManagementRootView(coordinator: self))
    }
}
