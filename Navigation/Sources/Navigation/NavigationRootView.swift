//
//  NavigationRootView.swift
//  Navigation
//
//  Created by Juan Carlos Hernandez Castillo on 23/04/25.
//

import SwiftUI
import Authentication
import Core
import UIComponents

public struct NavigationRootView: View {
    @StateObject private var coordinator = AppCoordinator()
    @StateObject private var toastManager = ToastManager.shared

    public init() {}

    public var body: some View {
        ZStack {
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

            ToastView(message: $toastManager.message,
                      type: $toastManager.type,
                      isVisible: $toastManager.isVisible)
        }
    }
}
