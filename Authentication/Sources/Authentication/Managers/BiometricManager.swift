//
//  BiometricManager.swift
//  Authentication
//
//  Created by Juan Carlos Hernandez Castillo on 8/05/25.
//

import DataPersistance
import LocalAuthentication

actor BiometricManager: BiometricManagerProtocol {

    private let keychain: KeychainProtocol
    private let context = LAContext()

    init(
        keychain: KeychainProtocol = KeychainManager.shared
    ) {
        self.keychain = keychain
    }

    func isBiometricAvailable() -> Bool {
        var error: NSError?
        return context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error)
    }

    func hasUsedBiometricsBefore() -> Bool {
        return retrieveCredentials() != nil
    }

    func authenticate() async -> Bool {
        let context = LAContext()
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

    func clearCredentials() {
        do {
            try keychain.delete(for: .biometricCredentials)
            print("Credenciales biométricas eliminadas del Keychain.")
        } catch {
            print("Error al eliminar credenciales del Keychain: \(error)")
        }
    }

}
