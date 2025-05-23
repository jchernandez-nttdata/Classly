//
//  RemoteConfigClient.swift
//  RemoteConfigClient
//
//  Created by Juan Carlos Hernandez Castillo on 22/05/25.
//

import Foundation
import FirebaseRemoteConfig

@MainActor
public final class RemoteConfigClient: ObservableObject {

    private let remoteConfig: RemoteConfig

    public init() {
        self.remoteConfig = RemoteConfig.remoteConfig()

        let settings = RemoteConfigSettings()
        settings.minimumFetchInterval = 0
        remoteConfig.configSettings = settings

        if let path = Bundle.module.path(forResource: "RemoteConfigDefaults", ofType: "plist"),
           let defaults = NSDictionary(contentsOfFile: path) as? [String: NSObject] {
            remoteConfig.setDefaults(defaults)
        }
    }

    public func fetchAndActivate() async -> Bool {
        await withCheckedContinuation { continuation in
            remoteConfig.fetchAndActivate { status, error in
                if let error = error {
                    print("⚠️ Remote Config error: \(error.localizedDescription)")
                    continuation.resume(returning: false)
                    return
                }

                switch status {
                case .successFetchedFromRemote, .successUsingPreFetchedData:
                    continuation.resume(returning: true)
                default:
                    continuation.resume(returning: false)
                }
            }
        }
    }

    public func stringValue(forKey key: RemoteConfigKey) -> String {
        return remoteConfig.configValue(forKey: key.rawValue).stringValue
    }
}
