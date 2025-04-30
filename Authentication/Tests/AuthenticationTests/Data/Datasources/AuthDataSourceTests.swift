//
//  AuthRemoteDataSourceTests.swift
//  Authentication
//
//  Created by Juan Carlos Hernandez Castillo on 30/04/25.
//

import Testing
@testable import Authentication
@testable import ClasslyNetworking
import Foundation

struct AuthRemoteDataSourceTests {

    @Test
    func testLoginSuccess() async throws {
        // Arrange
        let mockManager = MockNetworkManager()
        mockManager.customResponse = LoginResponse(
            id: 1,
            name: "Test",
            email: "test@email.com",
            dni: "12345678",
            password: "secret",
            phone: "999999999",
            role: "admin"
        )
        let dataSource = AuthRemoteDataSourceImpl(networkingManager: mockManager)
        let tPasswordParam = "1234"
        let tEmailParam = "test@email.com"

        // Act
        let userResponse = try await dataSource.login(email: tEmailParam, password: tPasswordParam)

        // Assert
        // Request
        #expect((mockManager.receivedRequest as? LoginApiRequest)?.body.email == tEmailParam)
        #expect((mockManager.receivedRequest as? LoginApiRequest)?.body.password == tPasswordParam)

        // Response
        #expect(userResponse.email == "test@email.com")
        #expect(userResponse.role == .admin)
    }

    @Test
    func testLoginUnauthorized() async throws {
        // Arrange
        let mockManager = MockNetworkManager()
        mockManager.customError = NetworkError.invalidResponse(statusCode: 401)
        let dataSource = AuthRemoteDataSourceImpl(networkingManager: mockManager)

        do {
            // Act
            _ = try await dataSource.login(email: "wrong@email.com", password: "wrong")
        } catch let error as LoginError {
            // Assert
            #expect(error == .unauthorized)
        }
    }

    @Test
    func testLoginInvalidData() async throws {
        // Arrange
        let mockManager = MockNetworkManager()
        mockManager.customError = NetworkError.invalidResponse(statusCode: 400)
        let dataSource = AuthRemoteDataSourceImpl(networkingManager: mockManager)

        do {
            // Act
            _ = try await dataSource.login(email: "wrong@email.com", password: "wrong")
        } catch let error as LoginError {
            // Assert
            #expect(error == .invalidData)
        }
    }

    @Test
    func testLoginUnknownError() async throws {
        // Arrange
        let mockManager = MockNetworkManager()
        mockManager.customError = NetworkError.requestFailed(NSError(domain: "", code: 0))
        let dataSource = AuthRemoteDataSourceImpl(networkingManager: mockManager)

        do {
            // Act
            _ = try await dataSource.login(email: "test@email.com", password: "1234")
        } catch let error as LoginError {
            // Assert
            #expect(error == .serverError)
        }
    }
}
