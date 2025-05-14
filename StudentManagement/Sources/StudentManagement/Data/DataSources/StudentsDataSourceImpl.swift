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
            throw StudentManagementNetworkErrorMapper.toLoadStudentsError(error)
        }
    }

    func addStudent(request: AddStudentUseCaseImpl.AddStudentRequest) async throws {
        do {
            let request = AddStudentApiRequest(from: request)
            _ = try await networkingManager.performRequest(request)
            return
        } catch {
            throw StudentManagementNetworkErrorMapper.toAddStudentError(error)
        }
    }
}
