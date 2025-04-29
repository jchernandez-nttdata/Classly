//
//  File.swift
//  Authentication
//
//  Created by Juan Carlos Hernandez Castillo on 29/04/25.
//

protocol LoginUseCase: UseCase where Request == LoginRequest, Response == User, Failure == LoginError {}

final class LoginUseCaseImpl: LoginUseCase {
    private let repository: AuthRepository

    init(repository: AuthRepository) {
        self.repository = repository
    }

    func execute(request: LoginRequest) async -> Result<User, LoginError> {
        return await repository.login(email: request.email, password: request.password)
    }
}
