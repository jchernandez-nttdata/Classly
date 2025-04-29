//
//  File.swift
//  Authentication
//
//  Created by Juan Carlos Hernandez Castillo on 29/04/25.
//

import ClasslyNetworking

final class AuthRemoteDataSourceImpl: AuthRemoteDataSource {
    private let networkingManager: NetworkManagerProtocol

    init(networkingManager: NetworkManagerProtocol) {
        self.networkingManager = networkingManager
    }

    func login(email: String, password: String) async throws -> User {
        do {
            let request = LoginApiRequest(email: email, password: password)
            let response = try await networkingManager.performRequest(request)
            return LoginResponseMapper.mapToUser(response: response)
        } catch {
            throw LoginError.serverError
        }
    }
}
