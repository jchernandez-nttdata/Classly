//
//  AuthRepositoryImpl.swift
//  Authentication
//
//  Created by Juan Carlos Hernandez Castillo on 29/04/25.
//

class AuthRepositoryImpl: AuthRepository {
    private let remoteDataSource: AuthRemoteDataSource

    init(remoteDataSource: AuthRemoteDataSource) {
        self.remoteDataSource = remoteDataSource
    }

    func login(email: String, password: String) async -> Result<User, LoginError> {
        do {
            let user = try await remoteDataSource.login(email: email, password: password)
            return .success(user)
        } catch let error as LoginError {
            return .failure(error)
        } catch {
            return .failure(.serverError)
        }
    }
}
