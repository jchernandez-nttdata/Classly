//
//  File.swift
//  ClassManagement
//
//  Created by Juan Carlos Hernandez Castillo on 16/05/25.
//

import Core

final class StudentsRepositoryImpl: StudentsRepository {

    private let remoteDataSource: StudentsDataSource

    init(remoteDataSource: StudentsDataSource) {
        self.remoteDataSource = remoteDataSource
    }

    func loadStudentsQuery(query: String) async throws(ClassManagementListError) -> [Student] {
        do {
            return try await remoteDataSource.loadStudentsQuery(query: query)
        } catch let error as ClassManagementListError {
            throw error
        } catch {
            throw .serverError
        }
    }
}
