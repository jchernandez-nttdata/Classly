//
//  File.swift
//  Core
//
//  Created by Juan Carlos Hernandez Castillo on 8/05/25.
//

import SwiftUI

@MainActor
public protocol UserSessionProtocol {
    var currentUser: UserSession? { get }
    var isAuthenticated: Bool { get }
    func saveSession(_ session: UserSession)
    func logout()
}
