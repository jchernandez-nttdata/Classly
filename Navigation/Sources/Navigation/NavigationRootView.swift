//
//  NavigationRootView.swift
//  Navigation
//
//  Created by Juan Carlos Hernandez Castillo on 23/04/25.
//

import SwiftUI
import Authentication

public struct NavigationRootView: View {
    @StateObject private var coordinator = AppCoordinator()

    public init() {}

    public var body: some View {
        Group {
            switch coordinator.state {
            case .authentication:
                if let authCoordinator = coordinator.authCoordinator {
                    authCoordinator.start()
                }
            case .admin:
                AdminTabView()
            case .student:
                StudentTabView()
            }
        }
        .environmentObject(coordinator)
    }
}
