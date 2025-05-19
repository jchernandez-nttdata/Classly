//
//  ClassManagementNetworkErrorMapper.swift
//  ClassManagement
//
//  Created by Juan Carlos Hernandez Castillo on 14/05/25.
//

import ClasslyNetworking

enum ClassManagementNetworkErrorMapper {
    static func toClassManagementListError(_ error: Error) -> ClassManagementListError {
        guard let networkError = error as? NetworkError else {
            return .serverError
        }

        switch networkError {
        case .invalidResponse(let code):
            switch code {
            case 400: return .invalidData
            case 404: return .networkError
            default: return .serverError
            }
        case .decodingFailed: return .requestError
        default: return .serverError
        }
    }

    static func toUnenrollStudentError(_ error: Error) -> UnenrollStudentError {
        guard let networkError = error as? NetworkError else {
            return .serverError
        }

        switch networkError {
        case .invalidResponse(let code):
            switch code {
            case 400: return .stillHaveClasses
            case 404: return .notFound
            default: return .serverError
            }
        case .decodingFailed: return .requestError
        default: return .serverError
        }
    }

    static func toEnrollStudentError(_ error: Error) -> EnrollStudentError {
        guard let networkError = error as? NetworkError else {
            return .serverError
        }

        switch networkError {
        case .invalidResponse(let code):
            switch code {
            case 400: return .requestError
            case 404: return .notFound
            default: return .serverError
            }
        case .decodingFailed: return .requestError
        default: return .serverError
        }
    }
}
