//
//  ScheduleRepositoryImpl.swift
//  ClassesStudent
//
//  Created by Juan Carlos Hernandez Castillo on 29/05/25.
//

class ScheduleRepositoryImpl: ScheduleRepository {
    private let remoteDataSource: ScheduleDataSource

    init(remoteDataSource: ScheduleDataSource) {
        self.remoteDataSource = remoteDataSource
    }
    
    func loadStudentClasses(studentId: Int) async throws(ClassesStudentListError) -> [StudentClass] {
        do {
            return try await remoteDataSource.loadStudentClasses(studentId: studentId)
        } catch let error as ClassesStudentListError {
            throw error
        } catch {
            throw .serverError
        }
    }
}
