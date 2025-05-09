//
//  LoginViewModel.swift
//  Authentication
//
//  Created by Juan Carlos Hernandez Castillo on 25/04/25.
//

import Foundation
import Core

@MainActor
final class LoginViewModel: ObservableObject {
    @Published public var email = ""
    @Published public var password = ""
    @Published public var isLoading = false

    private let coordinator: (any CoordinatorProtocol)?
    private let loginUseCase: LoginUseCase?
    private let userSessionManager: (any UserSessionProtocol)?

    init(
        coordinator: (any CoordinatorProtocol)? = nil,
        loginUseCase: LoginUseCase? = nil,
        userSessionManager: (any UserSessionProtocol)? = nil
    ) {
        self.coordinator = coordinator
        self.loginUseCase = loginUseCase
        self.userSessionManager = userSessionManager
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
                userSessionManager?.saveSession(session)
                guard let authCoordinator = coordinator as? AuthenticationCoordinator else { return }
                authCoordinator.exitModule(role: user.role)
            case .failure(let error):
                print("Login failed: \(error)")
            }
        }
    }
}
