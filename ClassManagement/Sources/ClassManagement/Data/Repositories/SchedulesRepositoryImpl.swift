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
}
