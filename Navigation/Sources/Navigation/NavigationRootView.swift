//
//  NavigationRootView.swift
//  Navigation
//
//  Created by Juan Carlos Hernandez Castillo on 23/04/25.
//

import SwiftUI

public struct NavigationRootView: View {
    @StateObject private var coordinator = AppCoordinator()

    public init() {}

    public var body: some View {
        Group {
            switch coordinator.state {
            case .authentication:
                VStack {
                    Button("Login as Admin") {
                        coordinator.login(as: .admin)
                    }
                    
                    Button("Login as Student") {
                        coordinator.login(as: .student)
                    }
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
