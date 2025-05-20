//
//  PaymentsManagementRootView.swift
//  PaymentsManagement
//
//  Created by Juan Carlos Hernandez Castillo on 20/05/25.
//

import SwiftUI

public struct PaymentsManagementRootView: View {
    @ObservedObject var coordinator: PaymentsManagementCoordinator

    public init(coordinator: PaymentsManagementCoordinator) {
        self.coordinator = coordinator
    }

    public var body: some View {
        NavigationStack(path: $coordinator.path) {
            coordinator.build(route: .paymentsList)
                .navigationDestination(for: PaymentManagementRoute.self) { route in
                    coordinator.build(route: route)
                }
        }
    }
}
