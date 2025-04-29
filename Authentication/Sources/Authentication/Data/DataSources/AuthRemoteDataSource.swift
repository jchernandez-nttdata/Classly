//
//  AuthRemoteDataSource.swift
//  Authentication
//
//  Created by Juan Carlos Hernandez Castillo on 29/04/25.
//

protocol AuthRemoteDataSource {
    func login(email: String, password: String) async throws -> User
}
