//
//  File.swift
//  Authentication
//
//  Created by Juan Carlos Hernandez Castillo on 29/04/25.
//

protocol AuthRepository {
    func login(email: String, password: String) async -> Result<User, LoginError>
}
