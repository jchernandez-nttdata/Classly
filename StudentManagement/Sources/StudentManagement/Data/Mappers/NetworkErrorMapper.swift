//
//  File.swift
//  StudentManagement
//
//  Created by Juan Carlos Hernandez Castillo on 13/05/25.
//

import ClasslyNetworking

enum StudentManagementNetworkErrorMapper {
    static func toLoadStudentsError(_ error: Error) -> LoadStudentsError {
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

    static func toManageStudentError(_ error: Error) -> ManageStudentError {
        guard let networkError = error as? NetworkError else {
            return .serverError
        }

        switch networkError {
        case .invalidResponse(let code):
            switch code {
            case 400: return .invalidData
            case 404: return .networkError
            case 409: return .duplicateStudent
            default: return .serverError
            }
        case .decodingFailed: return .requestError
        default: return .serverError
        }
    }
}
