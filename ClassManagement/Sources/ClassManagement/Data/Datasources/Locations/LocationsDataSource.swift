//
//  LocationsDataSource.swift
//  ClassManagement
//
//  Created by Juan Carlos Hernandez Castillo on 14/05/25.
//

protocol LocationsDataSource {
    func loadLocations() async throws -> [Location]
}
