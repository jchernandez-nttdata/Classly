//
//  StudentsDataSourceImpl.swift
//  StudentManagement
//
//  Created by Juan Carlos Hernandez Castillo on 7/05/25.
//

import ClasslyNetworking

final class StudentsDataSourceImpl: StudentsDataSource {

    private let networkingManager: NetworkManagerProtocol

    init(networkingManager: NetworkManagerProtocol) {
        self.networkingManager = networkingManager
    }

    func loadStudents() async throws -> [Student] {
        do {
            let request = LoadStudentsApiRequest()
            let response = try await networkingManager.performRequest(request)
            return StudentMapper.mapToStudents(responses: response)
        } catch {
            throw mapNetworkErrorToLoadStudentsError(error)
        }
    }

    private func mapNetworkErrorToLoadStudentsError(_ error: Error) -> LoadStudentsError {
        if let networkError = error as? NetworkError {
            switch networkError {
            case .invalidResponse(let statusCode):
                switch statusCode {
                case 400: return .invalidData
                case 404: return .networkError
                default: return .serverError
                }
            case .decodingFailed, .encodingFailed:
                return .requestError
            default:
                return .serverError
            }
        } else {
            return .serverError
        }
    }
}
