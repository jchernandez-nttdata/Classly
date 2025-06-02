//
//  LoginViewModel.swift
//  Authentication
//
//  Created by Juan Carlos Hernandez Castillo on 25/04/25.
//

import Foundation
import Core
import AnalyticsService

@MainActor
final class LoginViewModel: ObservableObject {
    @Published public var email = ""
    @Published public var password = ""
    @Published public var isLoading = false

    private let coordinator: (any CoordinatorProtocol)?
    private let loginUseCase: LoginUseCase?
    private let userSessionManager: (any UserSessionProtocol)?
    private let biometricManager: any BiometricManagerProtocol
    private let toastManager: ToastManager
    private let analyticsService: AnalyticsService

    init(
        coordinator: (any CoordinatorProtocol)? = nil,
        loginUseCase: LoginUseCase? = nil,
        userSessionManager: (any UserSessionProtocol)? = nil,
        biometricManagerProtocol: BiometricManagerProtocol = BiometricManager(),
        toastManager: ToastManager = .shared,
        analyticsService: AnalyticsService = .shared
    ) {
        self.coordinator = coordinator
        self.loginUseCase = loginUseCase
        self.userSessionManager = userSessionManager
        self.biometricManager = biometricManagerProtocol
        self.toastManager = toastManager
        self.analyticsService = analyticsService
    }

    func login() {
        guard let loginUseCase else { return }

        Task {
            isLoading = true

            // simulates loading
            try await Task.sleep(nanoseconds: 1_500_000_000)

            let params = LoginUseCaseImpl.Params(email: email, password: password)
            let result = await loginUseCase.execute(params: params)

            isLoading = false

            switch result {
            case .success(let user):
                let session = UserSession(
                    id: user.id,
                    email: user.email,
                    name: user.name
                )
                await userSessionManager?.saveSession(session)

                await handleBiometricCredentialsUpdate(currentEmail: email, currentPassword: password)

                await MainActor.run {
                    analyticsLogIn(user: user)

                    guard let authCoordinator = coordinator as? AuthenticationCoordinator else { return }
                    authCoordinator.exitModule(role: user.role)
                }
            case .failure(let error):
                switch error {
                case .unauthorized:
                    toastManager.showToast(message: "Invalid credentials", type: .error)
                case .invalidData:
                    toastManager.showToast(message: "Invalid data", type: .error)
                default:
                    toastManager.showToast(message: "Something went wrong. Please try again later", type: .error)
                }
            }
        }
    }

    private func handleBiometricCredentialsUpdate(currentEmail: String, currentPassword: String) async {
        guard await biometricManager.isBiometricAvailable() else { return }

        // Verificar si hay credenciales guardadas previamente
        let existingCredentials = await biometricManager.retrieveCredentials()
        let hasUsedBiometricsBefore = await biometricManager.hasUsedBiometricsBefore()

        if let existingCredentials = existingCredentials {
            // Si las credenciales son diferentes, actualizar automáticamente
            if existingCredentials.username != currentEmail {
                print("Detectadas credenciales diferentes. Actualizando automáticamente...")
                await updateBiometricCredentials(email: currentEmail, password: currentPassword)
            }
        } else if !hasUsedBiometricsBefore {
            print("No se ha utilizado biometría")
            let biometricResult = await biometricManager.authenticate()
            if biometricResult {
                try? await biometricManager.saveCredentials(username: currentEmail, password: currentPassword)
            }
        } else {
            print("else")
        }
    }

    private func updateBiometricCredentials(email: String, password: String) async {
        do {
            await biometricManager.clearCredentials()
            try await biometricManager.saveCredentials(username: email, password: password)
            print("Credenciales biométricas actualizadas exitosamente")
        } catch {
            print("Error al actualizar credenciales biométricas: \(error)")
        }
    }

    func authenticateWithBiometrics() {
        Task {
            let isBiometricAvailable = await biometricManager.isBiometricAvailable()
            let hasUsedBiometricsBefore = await biometricManager.hasUsedBiometricsBefore()
            if isBiometricAvailable && hasUsedBiometricsBefore {
                let biometricResult = await biometricManager.authenticate()
                if biometricResult {
                    let credentials = await biometricManager.retrieveCredentials()
                    if let credentials = credentials {
                        await MainActor.run {
                            self.email = credentials.username
                            self.password = credentials.password
                        }
                        await MainActor.run {
                            self.login()
                        }
                    }
                }
            }
        }
    }

    private func analyticsLogIn(user: User) {
        analyticsService.setUser(id: user.id, type: user.role == .admin ? .admin : .student)
        analyticsService.track(
            .custom(
                name: "login_success",
                parameters: [
                    "user_role": user.role.rawValue,
                    "name": user.name,
                    "id": user.id
                ]
            )
        )
    }
}
