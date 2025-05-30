//
//  AttendancesRepositoryImpl.swift
//  ClassManagement
//
//  Created by Juan Carlos Hernandez Castillo on 19/05/25.
//

class AttendancesRepositoryImpl: AttendancesRepository {

    private let remoteDataSource: AttendancesDataSource

    init(remoteDataSource: AttendancesDataSource) {
        self.remoteDataSource = remoteDataSource
    }

    func loadAttendancesDates(scheduleId: Int) async throws(ClassManagementListError) -> [String] {
        do {
            return try await remoteDataSource.loadAttendancesDates(scheduleId: scheduleId)
        } catch let error as ClassManagementListError {
            throw error
        } catch {
            throw .serverError
        }
    }

    func loadStudentAttendances(scheduleId: Int, date: String) async throws(ClassManagementListError) -> [StudentAttendance] {
        do {
            return try await remoteDataSource.loadStudentAttendances(scheduleId: scheduleId, date: date)
        } catch let error as ClassManagementListError {
            throw error
        } catch {
            throw .serverError
        }
    }
}
