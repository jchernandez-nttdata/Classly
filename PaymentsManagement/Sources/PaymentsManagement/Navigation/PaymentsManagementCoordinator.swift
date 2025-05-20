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
}

public final class PaymentsManagementCoordinator: CoordinatorProtocol {
    public typealias Route = PaymentManagementRoute
    public typealias Content = AnyView

    @Published public var path = NavigationPath()

//    private let di: ClassManagementDIContainer

//    public init(di: ClassManagementDIContainer) {
//        self.di = di
//    }

    public init() {
    }

    public func build(route: PaymentManagementRoute) -> AnyView {
        switch route {
        case .paymentsList:
            return AnyView(PaymentsListView())
        }
    }

    @ViewBuilder public func start() -> AnyView {
        AnyView(PaymentsManagementRootView(coordinator: self))
    }
}
