//
//  File.swift
//  Authentication
//
//  Created by Juan Carlos Hernandez Castillo on 29/04/25.
//

import Core

protocol LoginUseCase {
    func execute(params: LoginUseCaseImpl.Params) async -> Result<User, LoginError>
}

final class LoginUseCaseImpl: LoginUseCase {
    private let repository: AuthRepository

    struct Params: Codable {
        let email: String
        let password: String
    }

    init(repository: AuthRepository) {
        self.repository = repository
    }

    func execute(params: Params) async -> Result<User, LoginError> {
        return await repository.login(email: params.email, password: params.password)
    }
}
