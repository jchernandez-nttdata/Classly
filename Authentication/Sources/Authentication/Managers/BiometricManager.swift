//
//  BiometricManager.swift
//  Authentication
//
//  Created by Juan Carlos Hernandez Castillo on 8/05/25.
//

import DataPersistance
import LocalAuthentication

final class BiometricManager: BiometricManagerProtocol {

    private let keychain: KeychainProtocol
    private let defaults: UserDefaultsProtocol
    private let context = LAContext()

    init(
        keychain: KeychainProtocol = KeychainManager.shared,
        defaults: UserDefaultsProtocol = UserDefaultsManager.shared
    ) {
        self.keychain = keychain
        self.defaults = defaults
    }

    func isBiometricAvailable() -> Bool {
        var error: NSError?
        return context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error)
    }

    func hasUsedBiometricsBefore() -> Bool {
        defaults.get(key: .biometricUsedBefore) ?? false
    }

    func authenticate() async -> Bool {
        do {
            return try await context.evaluatePolicy(
                .deviceOwnerAuthenticationWithBiometrics,
                localizedReason: "Authenticate with Biometrics"
            )
        } catch {
            return false
        }
    }

    func saveCredentials(username: String, password: String) throws {
        let credentialsString = "\(username):\(password)"
        guard let data = credentialsString.data(using: .utf8) else {
            print("Error: No se pudo convertir las credenciales a Data.")
            return
        }

        do {
            try keychain.save(data, for: .biometricCredentials)
            print("Credenciales guardadas correctamente en Keychain.")
        } catch {
            print("Error al guardar en Keychain: \(error)")
        }

        defaults.set(value: true, key: .biometricUsedBefore)
    }

    func retrieveCredentials() -> (username: String, password: String)? {
        do {
            guard let data = try keychain.retrieve(for: .biometricCredentials),
                  let credentialsString = String(data: data, encoding: .utf8) else {
                return nil
            }

            let credentialsArray = credentialsString.split(separator: ":")
            guard credentialsArray.count == 2 else {
                print("Error: El formato de las credenciales es incorrecto.")
                return nil
            }

            let username = String(credentialsArray[0])
            let password = String(credentialsArray[1])

            return (username, password)
        } catch {
            print("Error al recuperar las credenciales de Keychain: \(error)")
            return nil
        }
    }

}
