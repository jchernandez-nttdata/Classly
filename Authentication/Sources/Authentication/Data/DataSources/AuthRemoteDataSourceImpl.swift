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
            throw mapNetworkErrorToLoginError(error)
        }
    }

    private func mapNetworkErrorToLoginError(_ error: Error) -> LoginError {
        if let networkError = error as? NetworkError {
            switch networkError {
            case .invalidResponse(let statusCode):
                switch statusCode {
                case 400: return .invalidData
                case 401: return .unauthorized
                case 404: return .networkError
                default: return .serverError
                }
            case .decodingFailed, .encodingFailed:
                return .requestError
            default:
                return .serverError
            }
        } else {
            return .serverError
        }
    }
}
