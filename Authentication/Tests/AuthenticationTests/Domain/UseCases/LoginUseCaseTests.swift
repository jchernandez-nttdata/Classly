//
//  LoginUseCaseTests.swift
//  Authentication
//
//  Created by Juan Carlos Hernandez Castillo on 30/04/25.
//

import Testing
@testable import Authentication

struct LoginUseCaseTests {

    @Test
    func testLoginSuccess() async throws {
        // Arrange
        let mockRepo = MockAuthRepository()
        mockRepo.shouldSucceed = true
        let useCase = LoginUseCaseImpl(repository: mockRepo)
        let params = LoginUseCaseImpl.Params(email: "test@email.com", password: "1234")

        // Act
        let result = await useCase.execute(params: params)

        // Assert
        #expect(mockRepo.loginCallCount == 1)
        switch result {
        case .success(let user):
            #expect(user.email == "test@email.com")
            #expect(user.role == .admin)
            #expect(mockRepo.receivedEmail == "test@email.com")
            #expect(mockRepo.receivedPassword == "1234")
        case .failure:
            break
        }
    }

    @Test
    func testLoginFailure() async throws {
        // Arrange
        let mockRepo = MockAuthRepository()
        mockRepo.shouldSucceed = false
        let useCase = LoginUseCaseImpl(repository: mockRepo)
        let params = LoginUseCaseImpl.Params(email: "test@email.com", password: "wrong")

        // Act
        let result = await useCase.execute(params: params)

        // Assert
        #expect(mockRepo.loginCallCount == 1)
        switch result {
        case .success:
            break
        case .failure(let error):
            #expect(error == .unauthorized)
        }
    }
}
