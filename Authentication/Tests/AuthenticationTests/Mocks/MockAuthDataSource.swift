//
//  MockAuthRemoteDataSource.swift
//  Authentication
//
//  Created by Juan Carlos Hernandez Castillo on 30/04/25.
//

@testable import Authentication

final class MockAuthRemoteDataSource: AuthRemoteDataSource {
    var shouldSucceed = true
    var shouldThrowLoginError: LoginError?
    var wasLoginCalled = false

    func login(email: String, password: String) async throws -> User {
        wasLoginCalled = true

        if let loginError = shouldThrowLoginError {
            throw loginError
        }

        if shouldSucceed {
            return User(
                id: 1,
                name: "Mock User",
                email: email,
                dni: "12345678",
                phone: "999999999",
                role: .admin
            )
        } else {
            throw LoginError.serverError
        }
    }
}
