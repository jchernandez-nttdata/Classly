//
//  LoadListError.swift
//  Core
//
//  Created by Juan Carlos Hernandez Castillo on 21/05/25.
//

public enum LoadListError: Error, Sendable {
    case invalidData
    case networkError
    case serverError
    case requestError
    case noDataFound
}
