//
//  ClasslyApp.swift
//  Classly
//
//  Created by Juan Carlos Hernandez Castillo on 4/04/25.
//

import SwiftUI
import Navigation

@main
struct ClasslyApp: App {

    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate

    var body: some Scene {
        WindowGroup {
            NavigationRootView()
        }
    }
}
