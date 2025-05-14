//
//  File.swift
//  StudentManagement
//
//  Created by Juan Carlos Hernandez Castillo on 7/05/25.
//

public enum LoadStudentsError: Error, Sendable {
    case invalidData
    case networkError
    case serverError
    case requestError
}

enum AddStudentError: Error, Sendable {
    case invalidData
    case duplicateStudent
    case networkError
    case serverError
    case requestError
}
