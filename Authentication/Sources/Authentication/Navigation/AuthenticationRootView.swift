//
//  AuthenticationRootView.swift
//  Authentication
//
//  Created by Juan Carlos Hernandez Castillo on 25/04/25.
//

import SwiftUI

public struct AuthenticationRootView: View {
    @ObservedObject var coordinator: AuthenticationCoordinator

    public init(coordinator: AuthenticationCoordinator) {
        self.coordinator = coordinator
    }

    public var body: some View {
        NavigationStack(path: $coordinator.path) {
            EmptyView()
                .navigationDestination(for: AuthRoute.self) { route in
                    coordinator.build(route: route)
                }
        }
    }
}
