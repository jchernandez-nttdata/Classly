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
    private let biometricManager: BiometricManagerProtocol
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
        let biometricManager = biometricManager

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

                // faceID logic
                //TODO: Validate when to clear data
                if biometricManager.isBiometricAvailable() && !biometricManager.hasUsedBiometricsBefore()  {
                    let biometricResult = await biometricManager.authenticate()
                    if biometricResult {
                        try biometricManager.saveCredentials(username: email, password: password)
                    }
                }

                analyticsLogIn(user: user)

                guard let authCoordinator = coordinator as? AuthenticationCoordinator else { return }
                authCoordinator.exitModule(role: user.role)
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

    func authenticateWithBiometrics() {
        let biometricManager = biometricManager
        Task {
            if biometricManager.isBiometricAvailable() && biometricManager.hasUsedBiometricsBefore()  {
                let biometricResult = await biometricManager.authenticate()
                if biometricResult {
                    let credentials = biometricManager.retrieveCredentials()
                    if let credentials = credentials {
                        email = credentials.username
                        password = credentials.password
                        login()
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
