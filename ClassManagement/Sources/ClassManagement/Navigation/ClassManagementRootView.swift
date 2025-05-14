//
//  ClassManagementRootView.swift
//  ClassManagement
//
//  Created by Juan Carlos Hernandez Castillo on 14/05/25.
//

import SwiftUI

public struct ClassManagementRootView: View {
    @ObservedObject var coordinator: ClassManagementCoordinator

    public init(coordinator: ClassManagementCoordinator) {
        self.coordinator = coordinator
    }

    public var body: some View {
        NavigationStack(path: $coordinator.path) {
            coordinator.build(route: .classList)
                .navigationDestination(for: ClassManagementRoute.self) { route in
                    coordinator.build(route: route)
                }
        }
    }
}
