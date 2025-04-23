//
//  StudentTabView.swift
//  Navigation
//
//  Created by Juan Carlos Hernandez Castillo on 23/04/25.
//

import SwiftUI

public struct StudentTabView: View {
    public init() {}

    public var body: some View {
        TabView {
            Text("Classes")
                .tabItem { Label("Classes", systemImage: "calendar") }

            Text("History")
                .tabItem { Label("History", systemImage: "clock.arrow.circlepath") }
        }
    }
}
