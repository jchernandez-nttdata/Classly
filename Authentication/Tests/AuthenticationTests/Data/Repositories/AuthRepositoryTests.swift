//
//  AuthRepositoryTests.swift
//  Authentication
//
//  Created by Juan Carlos Hernandez Castillo on 30/04/25.
//

import Testing
@testable import Authentication

struct AuthRepositoryTests {

    @Test
    func testLoginSuccess() async throws {
        // Arrange
        let mockDataSource = MockAuthRemoteDataSource()
        mockDataSource.shouldSucceed = true
        let repository = AuthRepositoryImpl(remoteDataSource: mockDataSource)

        // Act
        let result = await repository.login(email: "user@test.com", password: "1234")

        // Assert
        #expect(mockDataSource.wasLoginCalled)
        switch result {
        case .success(let user):
            #expect(user.email == "user@test.com")
        case .failure:
            break
        }
    }

    @Test
    func testLoginThrowsLoginError() async throws {
        // Arrange
        let mockDataSource = MockAuthRemoteDataSource()
        mockDataSource.shouldThrowLoginError = .unauthorized
        let repository = AuthRepositoryImpl(remoteDataSource: mockDataSource)

        // Act
        let result = await repository.login(email: "bad@test.com", password: "wrong")

        // Assert
        #expect(mockDataSource.wasLoginCalled)
        switch result {
        case .success:
            break
        case .failure(let error):
            #expect(error == .unauthorized)
        }
    }

    @Test
    func testLoginThrowsUnexpectedError() async throws {
        // Arrange
        let mockDataSource = MockAuthRemoteDataSource()
        mockDataSource.shouldSucceed = false
        let repository = AuthRepositoryImpl(remoteDataSource: mockDataSource)

        // Act
        let result = await repository.login(email: "error@test.com", password: "1234")

        // Assert
        #expect(mockDataSource.wasLoginCalled)
        switch result {
        case .success:
            break
        case .failure(let error):
            #expect(error == .serverError)
        }
    }
}
