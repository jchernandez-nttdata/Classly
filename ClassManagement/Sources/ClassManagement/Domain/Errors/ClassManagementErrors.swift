//
//  File.swift
//  ClassManagement
//
//  Created by Juan Carlos Hernandez Castillo on 14/05/25.
//

public enum ClassManagementListError: Error, Sendable {
    case invalidData
    case networkError
    case serverError
    case requestError
    case noDataFound
}

enum UnenrollStudentError: Error, Sendable {
    case networkError
    case serverError
    case requestError
    case notFound
    case stillHaveClasses
}

enum EnrollStudentError: Error, Sendable {
    case networkError
    case serverError
    case requestError
    case notFound
    case parseError
}
