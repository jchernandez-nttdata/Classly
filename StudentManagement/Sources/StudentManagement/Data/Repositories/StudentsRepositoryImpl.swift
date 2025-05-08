//
//  StudentsRepositoryImpl.swift
//  StudentManagement
//
//  Created by Juan Carlos Hernandez Castillo on 7/05/25.
//

class StudentsRepositoryImpl: StudentsRepository {
    private let remoteDataSource: StudentsDataSource

    init(remoteDataSource: StudentsDataSource) {
        self.remoteDataSource = remoteDataSource
    }

    func loadStudents() async throws(LoadStudentsError) -> [Student] {
        do {
            return try await remoteDataSource.loadStudents()
        } catch let error as LoadStudentsError {
            throw error
        } catch {
            throw .serverError
        }
    }
}
