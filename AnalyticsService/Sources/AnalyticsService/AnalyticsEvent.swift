//
//  File.swift
//  AnalyticsService
//
//  Created by Juan Carlos Hernandez Castillo on 1/06/25.
//

public enum AnalyticsEvent {
    // Screen Events
    case screenView(screenName: String)

    // QR Scanner Events
    case qrScanStarted
    case qrScanSuccess(locationId: Int)
    case qrScanFailed(reason: String)

    case custom(name: String, parameters: [String: Any] = [:])
}

public enum UserType: String {
    case student = "student"
    case admin = "admin"
}
