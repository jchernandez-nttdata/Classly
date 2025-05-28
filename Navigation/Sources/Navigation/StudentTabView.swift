//
//  StudentTabView.swift
//  Navigation
//
//  Created by Juan Carlos Hernandez Castillo on 23/04/25.
//

import SwiftUI

public struct StudentTabView: View {

    @EnvironmentObject private var appCoordinator: AppCoordinator

    public init() {}
    
    public var body: some View {
        TabView {
            if let classesStudentCoordinator = appCoordinator.classesStudentCoordinator {
                classesStudentCoordinator.start()
                    .tabItem { Label("Classes", systemImage: "calendar") }
            }

            Text("History")
                .tabItem { Label("History", systemImage: "clock.arrow.circlepath") }
        }
    }
}
