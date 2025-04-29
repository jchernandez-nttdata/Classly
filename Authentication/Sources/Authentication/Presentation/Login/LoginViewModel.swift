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
    @Published public var isLoading = false

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
            isLoading = true
            let params = LoginUseCaseImpl.Params(email: email, password: password)
            // simulates loading
            try await Task.sleep(nanoseconds: 1_500_000_000)
            let result = await loginUseCase.execute(params: params)
            isLoading = false
            await MainActor.run {
                switch result {
                case .success(let user):
                    print("Logged in: \(user)")
                case .failure(let error):
                    print("Login failed: \(error)")
                }
            }
        }
    }
}
