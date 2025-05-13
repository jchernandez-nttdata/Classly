//
//  File.swift
//  Core
//
//  Created by Juan Carlos Hernandez Castillo on 8/05/25.
//

import SwiftUI

public protocol UserSessionProtocol: Sendable {
    var currentUser: UserSession? { get async }
    var isAuthenticated: Bool { get async }
    func saveSession(_ session: UserSession) async
    func logout() async
}
