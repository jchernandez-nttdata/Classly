//
//  LocationsDataSourceImpl.swift
//  ClassManagement
//
//  Created by Juan Carlos Hernandez Castillo on 14/05/25.
//

import ClasslyNetworking

final class LocationsDataSourceImpl: LocationsDataSource {

    private let networkingManager: NetworkManagerProtocol

    init(networkingManager: NetworkManagerProtocol) {
        self.networkingManager = networkingManager
    }

    func loadLocations() async throws -> [Location] {
        do {
            let request = LoadLocationsApiRequest()
            let response = try await networkingManager.performRequest(request)
            return LocationMapper.mapToLocations(responses: response)
        } catch {
            throw ClassManagementNetworkErrorMapper.toLoadLocationsError(error)
        }
    }
}
