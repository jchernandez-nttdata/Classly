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

    func loadClassScheduleByLocationId(locationId: Int) async throws(LoadClassSchedulesError) -> [ClassSchedule] {
        do {
            return try await remoteDataSource.loadClassScheduleByLocationId(locationId: locationId)
        } catch let error as LoadClassSchedulesError {
            throw error
        } catch {
            throw .serverError
        }
    }
}
