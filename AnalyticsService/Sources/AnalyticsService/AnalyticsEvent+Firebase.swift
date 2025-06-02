//
//  File.swift
//  AnalyticsService
//
//  Created by Juan Carlos Hernandez Castillo on 1/06/25.
//

import FirebaseAnalytics

extension AnalyticsEvent {
    var firebaseData: (eventName: String, parameters: [String: Any]) {
        switch self {

        case .screenView(let screenName):
            return (
                AnalyticsEventScreenView,
                [AnalyticsParameterScreenName: screenName]
            )

        case .qrScanStarted:
            return ("qr_scan_started", [:])

        case .qrScanSuccess(let locationId):
            return (
                "qr_scan_success",
                ["location_id": locationId]
            )

        case .qrScanFailed(let reason):
            return (
                "qr_scan_failed",
                ["failure_reason": reason]
            )

        case .custom(let name, let parameters):
            return (name, parameters)
        }
    }
}
