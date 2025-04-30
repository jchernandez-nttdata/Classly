//
//  File.swift
//  Authentication
//
//  Created by Juan Carlos Hernandez Castillo on 30/04/25.
//

@testable import Authentication

final class MockAuthRepository: AuthRepository {
    var shouldSucceed = true
    var receivedEmail: String?
    var receivedPassword: String?
    var loginCallCount: Int = 0

    func login(
        email: String,
        password: String
    ) async -> Result<User, LoginError> {
        receivedEmail = email
        receivedPassword = password
        loginCallCount += 1

        if shouldSucceed {
            let mockUser = User(
                id: 1,
                name: "test",
                email: "test@email.com",
                dni: "72758223",
                phone: "987654321",
                role: .admin
            )
            return .success(mockUser)
        } else {
            return .failure(.unauthorized)
        }
    }
}
