//
//  StudentsDataSourceImpl.swift
//  StudentManagement
//
//  Created by Juan Carlos Hernandez Castillo on 7/05/25.
//

import ClasslyNetworking
import Core

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

    func addStudent(request: AddStudentImpl.AddStudentRequest) async throws {
        do {
            let request = AddStudentApiRequest(from: request)
            _ = try await networkingManager.performRequest(request)
            return
        } catch {
            throw StudentManagementNetworkErrorMapper.toManageStudentError(error)
        }
    }

    func editStudent(request: EditStudentImpl.EditStudentRequest) async throws {
        do {
            let request = EditStudentApiRequest(from: request)
            _ = try await networkingManager.performRequest(request)
            return
        } catch {
            throw StudentManagementNetworkErrorMapper.toManageStudentError(error)
        }
    }
}
