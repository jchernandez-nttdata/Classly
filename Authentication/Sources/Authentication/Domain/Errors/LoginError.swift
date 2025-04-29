//
//  File.swift
//  Authentication
//
//  Created by Juan Carlos Hernandez Castillo on 29/04/25.
//

public enum LoginError: Error, Sendable {
    case unauthorized
    case invalidData
    case networkError
    case serverError
    case requestError
}
