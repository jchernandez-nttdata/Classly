//
//  AppCoordinator.swift
//  Navigation
//
//  Created by Juan Carlos Hernandez Castillo on 23/04/25.
//

import SwiftUI
import Authentication

@MainActor
public final class AppCoordinator: ObservableObject {
    @Published public var state: NavigationState = .authentication
    public var authCoordinator: AuthenticationCoordinator?

    public init() {
        setupAuthenticationCoordinator()
    }

    public func login(as userType: UserType) {
        switch userType {
        case .admin:
            state = .admin
        case .student:
            state = .student
        }
    }

    public func logout() {
        state = .authentication
    }

    private func setupAuthenticationCoordinator() {
        authCoordinator = AuthenticationCoordinator(onExit: { [weak self] in
            self?.login(as: .admin)
        })
    }
}
