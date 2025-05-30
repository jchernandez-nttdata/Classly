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
}
