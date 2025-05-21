//
//  PaymentsManagementErrors.swift
//  PaymentsManagement
//
//  Created by Juan Carlos Hernandez Castillo on 21/05/25.
//

public enum PaymentsManagementListError: Error, Sendable {
    case invalidData
    case networkError
    case serverError
    case requestError
    case noDataFound
}
