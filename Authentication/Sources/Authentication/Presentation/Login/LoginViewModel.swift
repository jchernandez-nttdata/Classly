//
//  LoginViewModel.swift
//  Authentication
//
//  Created by Juan Carlos Hernandez Castillo on 25/04/25.
//

import Foundation

@MainActor
final class LoginViewModel<U: LoginUseCase>: ObservableObject {
    @Published public var email = ""
    @Published public var password = ""

    private let coordinator: (any CoordinatorProtocol)?
    private let loginUseCase: U?

    init(
        coordinator: (any CoordinatorProtocol)? = nil,
        loginUseCase: U? = nil
    ) {
        self.coordinator = coordinator
        self.loginUseCase = loginUseCase
    }

    func login() {
        guard let loginUseCase else { return }
        Task {
            let request = LoginRequest(email: email, password: password)
            let result = await loginUseCase.execute(request: request)

            switch result {
            case .success(let user):
                print("Logged in: \(user)")
            case .failure(let error):
                print("Login failed: \(error)")
            }
        }
    }
}
