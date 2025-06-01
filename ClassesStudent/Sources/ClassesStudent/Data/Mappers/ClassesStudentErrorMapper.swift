//
//  ClassesStudentErrorMapper.swift
//  ClassesStudent
//
//  Created by Juan Carlos Hernandez Castillo on 29/05/25.
//

import ClasslyNetworking

struct ClassesStudentErrorMapper {
    static func toClassStudentListError(_ error: Error) -> ClassesStudentListError {
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

    static func toAddAttendanceError(_ error: Error) -> AddAssistanceError {
        guard let networkError = error as? NetworkError else {
            return .serverError
        }

        switch networkError {
        case .invalidResponse(let code):
            switch code {
            case 400: return .locationMismatch
            case 403: return .classNotToday
            case 409: return .alreadyRegistered
            case 422: return .noRemainingClasses
            case 404: return .networkError
            default: return .serverError
            }
        case .decodingFailed: return .requestError
        default: return .serverError
        }
    }
}
