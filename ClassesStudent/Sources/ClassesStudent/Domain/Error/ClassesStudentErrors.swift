//
//  ClassesStudentErrors.swift
//  ClassesStudent
//
//  Created by Juan Carlos Hernandez Castillo on 29/05/25.
//

public enum ClassesStudentListError: Error, Sendable {
    case invalidData
    case networkError
    case serverError
    case requestError
    case noDataFound
}

public enum AddAssistanceError: Error, Sendable {
    case networkError
    case serverError
    case requestError
    case noRemainingClasses
    case locationMismatch
    case classNotToday
    case alreadyRegistered
}
