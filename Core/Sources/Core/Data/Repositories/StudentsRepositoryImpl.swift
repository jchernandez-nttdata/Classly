//
//  StudentsRepositoryImpl.swift
//  Core
//
//  Created by Juan Carlos Hernandez Castillo on 21/05/25.
//

public final class StudentsRepositoryImpl: StudentsRepository {

    private let remoteDataSource: StudentsDataSource

    public init(remoteDataSource: StudentsDataSource) {
        self.remoteDataSource = remoteDataSource
    }

    public func loadStudentsQuery(query: String) async throws(LoadListError) -> [Student] {
        do {
            return try await remoteDataSource.loadStudentsQuery(query: query)
        } catch let error as LoadListError {
            throw error
        } catch {
            throw .serverError
        }
    }
}
