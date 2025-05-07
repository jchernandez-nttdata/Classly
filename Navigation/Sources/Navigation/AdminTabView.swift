//
//  AdminTabView.swift
//  Navigation
//
//  Created by Juan Carlos Hernandez Castillo on 23/04/25.
//

import SwiftUI

public struct AdminTabView: View {

    @EnvironmentObject private var appCoordinator: AppCoordinator

    public init() {}

    public var body: some View {
        TabView {
            if let studentCoordinator = appCoordinator.studentManagementCoordinator {
                studentCoordinator.start()
                    .tabItem { Label("Students", systemImage: "person.3") }
            }

            Text("Classes")
                .tabItem { Label("Classes", systemImage: "book") }

            Text("Payments")
                .tabItem { Label("Payments", systemImage: "creditcard") }
        }
    }
}
