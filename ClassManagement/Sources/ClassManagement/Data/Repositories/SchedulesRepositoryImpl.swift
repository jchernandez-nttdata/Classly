//
//  SchedulesRepositoryImpl.swift
//  ClassManagement
//
//  Created by Juan Carlos Hernandez Castillo on 15/05/25.
//

class SchedulesRepositoryImpl: SchedulesRepository {

    private let remoteDataSource: SchedulesDataSource

    init(remoteDataSource: SchedulesDataSource) {
        self.remoteDataSource = remoteDataSource
    }

    func loadClassScheduleByLocationId(locationId: Int) async throws(ClassManagementListError) -> [ClassSchedule] {
        do {
            return try await remoteDataSource.loadClassScheduleByLocationId(locationId: locationId)
        } catch let error as ClassManagementListError {
            throw error
        } catch {
            throw .serverError
        }
    }

    func loadEnrolledStudentsByScheduleId(scheduleId: Int) async throws(ClassManagementListError) -> [EnrolledStudent] {
        do {
            return try await remoteDataSource.loadEnrolledStudentsByScheduleId(scheduleId: scheduleId)
        } catch let error as ClassManagementListError {
            throw error
        } catch {
            throw .serverError
        }
    }

    func unenrollStudent(studentId: Int, scheduleId: Int) async throws(UnenrollStudentError) {
        do {
            return try await remoteDataSource.unenrollStudent(studentId: studentId, scheduleId: scheduleId)
        } catch let error as UnenrollStudentError {
            throw error
        } catch {
            throw .serverError
        }
    }

    func enrollStudent(params: EnrollStudentImpl.Params) async throws(EnrollStudentError) {
        do {
            return try await remoteDataSource.enrollStudent(params: params)
        } catch let error as EnrollStudentError {
            throw error
        } catch {
            throw .serverError
        }
    }
}
