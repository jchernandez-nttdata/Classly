//
//  ClassesStudentRootView.swift
//  ClassesStudent
//
//  Created by Juan Carlos Hernandez Castillo on 28/05/25.
//

import SwiftUI

public struct ClassesStudentRootView: View {
    @ObservedObject var coordinator: ClassesStudentCoordinator

    public init(coordinator: ClassesStudentCoordinator) {
        self.coordinator = coordinator
    }

    public var body: some View {
        NavigationStack(path: $coordinator.path) {
            coordinator.build(route: .classList)
                .navigationDestination(for: ClassesStudentRoute.self) { route in
                    coordinator.build(route: route)
                }
        }
    }
}
