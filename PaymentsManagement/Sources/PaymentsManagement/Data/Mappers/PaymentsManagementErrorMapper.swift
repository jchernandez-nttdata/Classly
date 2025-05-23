//
//  PaymentsManagementErrorMapper.swift
//  PaymentsManagement
//
//  Created by Juan Carlos Hernandez Castillo on 21/05/25.
//

import ClasslyNetworking

struct PaymentsManagementErrorMapper {
    static func toPaymentsManagementListError(_ error: Error) -> PaymentsManagementListError {
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

    static func toAddPaymentError(_ error: Error) -> AddPaymentError {
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
