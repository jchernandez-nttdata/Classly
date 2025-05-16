//
//  LocationsRepository.swift
//  ClassManagement
//
//  Created by Juan Carlos Hernandez Castillo on 14/05/25.
//

import Foundation

protocol LocationsRepository {
    func loadLocations() async throws(ClassManagementListError) -> [Location]
}
