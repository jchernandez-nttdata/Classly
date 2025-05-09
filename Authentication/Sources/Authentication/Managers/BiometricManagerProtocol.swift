//
//  File.swift
//  Authentication
//
//  Created by Juan Carlos Hernandez Castillo on 8/05/25.
//

import Core

protocol BiometricManagerProtocol {
    func isBiometricAvailable() -> Bool
    func hasUsedBiometricsBefore() -> Bool
    func authenticate() async -> Bool
    func saveCredentials(username: String, password: String) throws
    func retrieveCredentials() -> (username: String, password: String)?
}
