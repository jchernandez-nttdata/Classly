//
//  AppCoordinator.swift
//  Navigation
//
//  Created by Juan Carlos Hernandez Castillo on 23/04/25.
//

import SwiftUI
import Authentication
import Core
import StudentManagement

@MainActor
public final class AppCoordinator: ObservableObject {
    @Published public var state: NavigationState = .authentication
    public var authCoordinator: AuthenticationCoordinator?
    public var studentManagementCoordinator: StudentManagementCoordinator?

    public init() {
        setupAuthenticationCoordinator()
    }

    public func login(as role: UserRole) {
        switch role {
        case .admin:
            studentManagementCoordinator = StudentManagementCoordinator()
            state = .admin
        case .student:
            state = .student
        }
    }

    public func logout() {
        state = .authentication

        studentManagementCoordinator = nil
    }

    private func setupAuthenticationCoordinator() {
        authCoordinator = AuthenticationCoordinator(onExit: { [weak self] role in
            self?.login(as: role)
        })
    }
}
