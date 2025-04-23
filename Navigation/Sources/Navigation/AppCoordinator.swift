//
//  AppCoordinator.swift
//  Navigation
//
//  Created by Juan Carlos Hernandez Castillo on 23/04/25.
//

import SwiftUI

public final class AppCoordinator: ObservableObject {
    @Published public var state: NavigationState = .authentication

    public init() {}

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
}
