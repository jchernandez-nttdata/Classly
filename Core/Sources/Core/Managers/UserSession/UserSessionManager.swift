//
//  File.swift
//  Core
//
//  Created by Juan Carlos Hernandez Castillo on 8/05/25.
//

import SwiftUI

public actor UserSessionManager: UserSessionProtocol {
    public static let shared = UserSessionManager()

    public var _currentUser: UserSession? = nil
    public var _isAuthenticated: Bool = false

    private init() {}

    public var currentUser: UserSession? {
        _currentUser
    }

    public var isAuthenticated: Bool {
        _isAuthenticated
    }

    public func saveSession(_ session: UserSession) {
        self._currentUser = session
        self._isAuthenticated = true
    }

    public func logout() {
        self._currentUser = nil
        self._isAuthenticated = false
    }
}

