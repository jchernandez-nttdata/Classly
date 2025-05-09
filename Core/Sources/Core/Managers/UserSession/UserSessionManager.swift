//
//  File.swift
//  Core
//
//  Created by Juan Carlos Hernandez Castillo on 8/05/25.
//

import SwiftUI

@MainActor
public final class UserSessionManager: UserSessionProtocol {
    public static let shared = UserSessionManager()

    public var currentUser: UserSession? = nil
    public var isAuthenticated: Bool = false

    private init() {}

    public func saveSession(_ session: UserSession) {
        self.currentUser = session
        self.isAuthenticated = true
    }

    public func logout() {
        self.currentUser = nil
        self.isAuthenticated = false
    }
}

