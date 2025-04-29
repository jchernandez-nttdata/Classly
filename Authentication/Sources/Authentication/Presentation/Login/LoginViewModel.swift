//
//  LoginViewModel.swift
//  Authentication
//
//  Created by Juan Carlos Hernandez Castillo on 25/04/25.
//

import Foundation

@MainActor
final class LoginViewModel: ObservableObject {
    @Published public var email = ""
    @Published public var password = ""

    private let coordinator: (any CoordinatorProtocol)?
    private let loginUseCase: LoginUseCase?

    init(
        coordinator: (any CoordinatorProtocol)? = nil,
        loginUseCase: LoginUseCase? = nil
    ) {
        self.coordinator = coordinator
        self.loginUseCase = loginUseCase
    }

    func login() {
        guard let loginUseCase else { return }
        Task {
            let params = LoginUseCaseImpl.Params(email: email, password: password)
            let result = await loginUseCase.execute(params: params)

            switch result {
            case .success(let user):
                print("Logged in: \(user)")
            case .failure(let error):
                print("Login failed: \(error)")
            }
        }
    }
}
