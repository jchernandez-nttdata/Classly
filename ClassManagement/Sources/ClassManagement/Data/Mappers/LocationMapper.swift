//
//  LocationMapper.swift
//  ClassManagement
//
//  Created by Juan Carlos Hernandez Castillo on 14/05/25.
//

class LocationMapper {
    private static func mapToLocation(response: LoadLocationsResponse) -> Location {
        return Location(
            id: response.id,
            name: response.locationName,
            address: response.address
        )
    }

    static func mapToLocations(responses: [LoadLocationsResponse]) -> [Location] {
        return responses.map(mapToLocation)
    }
}
