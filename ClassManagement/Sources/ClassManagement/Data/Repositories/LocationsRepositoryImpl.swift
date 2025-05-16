//
//  LocationsRepositoryImpl.swift
//  ClassManagement
//
//  Created by Juan Carlos Hernandez Castillo on 14/05/25.
//

class LocationsRepositoryImpl: LocationsRepository {

    private let remoteDataSource: LocationsDataSource

    init(remoteDataSource: LocationsDataSource) {
        self.remoteDataSource = remoteDataSource
    }

    func loadLocations() async throws(ClassManagementListError) -> [Location] {
        do {
            return try await remoteDataSource.loadLocations()
        } catch let error as ClassManagementListError {
            throw error
        } catch {
            throw .serverError
        }
    }
}
