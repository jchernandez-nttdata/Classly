//
//  AnalyticsService.swift
//  AnalyticsService
//
//  Created by Juan Carlos Hernandez Castillo on 1/06/25.
//

import FirebaseAnalytics
import Foundation

public final class AnalyticsService: Sendable {
    public static let shared: AnalyticsService = {
        let instance = AnalyticsService()
        return instance
    }()

    private init() {}

    public func track(_ event: AnalyticsEvent) {
        let (eventName, parameters) = event.firebaseData

        Analytics.logEvent(eventName, parameters: parameters)

        #if DEBUG
        print("📊 Analytics: \(eventName)")
        if !parameters.isEmpty {
            print("   Parameters: \(parameters)")
        }
        #endif
    }

    public func setUser(id: Int, type: UserType) {
        Analytics.setUserID(String(id))
        Analytics.setUserProperty(type.rawValue, forName: "user_type")

        #if DEBUG
        print("👤 Analytics: User set - ID: \(id), Type: \(type.rawValue)")
        #endif
    }

    public func clearUser() {
        Analytics.setUserID(nil)
        Analytics.setUserProperty(nil, forName: "user_type")

        #if DEBUG
        print("👤 Analytics: User cleared")
        #endif
    }
}
