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

    func loadLocations() async throws(LoadLocationsError) -> [Location] {
        do {
            return try await remoteDataSource.loadLocations()
        } catch let error as LoadLocationsError {
            throw error
        } catch {
            throw .serverError
        }
    }
}
