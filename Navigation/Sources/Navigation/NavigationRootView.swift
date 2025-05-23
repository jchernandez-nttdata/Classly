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
import RemoteConfigClient

public struct NavigationRootView: View {
    @StateObject private var coordinator = AppCoordinator()
    @StateObject private var toastManager = ToastManager.shared
    @StateObject private var remoteConfigClient = RemoteConfigClient()

    @State private var showUpdateAlert = false

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
        .overlay(
            ToastView(message: $toastManager.message,
                      type: $toastManager.type,
                      isVisible: $toastManager.isVisible)
        )
        .task {
            await fetchRemoteConfig()
        }
        .alert("App Update Required", isPresented: $showUpdateAlert) {
            Button("Go to AppStore") {
                // redirect to appstore

            }
        } message: {
            Text("Please update your app to continue using Classly.")
        }
    }

    private func fetchRemoteConfig() async {
        let success = await remoteConfigClient.fetchAndActivate()
        if success {
            let minVersion = remoteConfigClient.stringValue(forKey: .minimumRequiredVersion)
            print("✅ Remote Config fetch success. Minimum version: \(minVersion)")

            if isAppVersionOutdated(minVersion) {
                print("⚠️ App is not up to date. Showing update alert")
                showUpdateAlert = true
            }
        } else {
            print("❌ Remote Config fetch failed")
        }
    }

    private func isAppVersionOutdated(_ minVersion: String) -> Bool {
        let currentVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? "0"
        return currentVersion.compare(minVersion, options: .numeric) == .orderedAscending
    }
}

