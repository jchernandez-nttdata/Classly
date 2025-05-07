//
//  StudentManagementRootView.swift
//  StudentManagement
//
//  Created by Juan Carlos Hernandez Castillo on 6/05/25.
//

import SwiftUI

public struct StudentManagementRootView: View {
    @ObservedObject var coordinator: StudentManagementCoordinator

    public init(coordinator: StudentManagementCoordinator) {
        self.coordinator = coordinator
    }

    public var body: some View {
        NavigationStack(path: $coordinator.path) {
            EmptyView()
                .navigationDestination(for: StudentManagementRoute.self) { route in
                    coordinator.build(route: route)
                }
        }
    }
}
