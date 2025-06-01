//
//  ScheduleRepositoryImpl.swift
//  ClassesStudent
//
//  Created by Juan Carlos Hernandez Castillo on 29/05/25.
//

final class ScheduleRepositoryImpl: ScheduleRepository {
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

    func addAttendance(userScheduleId: Int, locationId: Int) async throws(AddAssistanceError) {
        do {
            return try await remoteDataSource.addAttendance(
                userScheduleId: userScheduleId,
                locationId: locationId
            )
        } catch let error as AddAssistanceError {
            throw error
        } catch {
            throw .serverError
        }
    }
}
