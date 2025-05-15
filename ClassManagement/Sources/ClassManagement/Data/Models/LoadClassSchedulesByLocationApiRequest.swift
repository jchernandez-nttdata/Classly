//
//  LoadClassSchedulesByLocationApiRequest.swift
//  ClassManagement
//
//  Created by Juan Carlos Hernandez Castillo on 15/05/25.
//

import ClasslyNetworking

struct LoadClassSchedulesByLocationApiRequest: Request {
    typealias Response = [LoadClassSchedulesByLocationResponse]

    var urlMethod: HTTPMethod = .GET
    var endpoint: String { "/locations/\(locationId)/schedules" }

    var locationId: Int
}

struct LoadClassSchedulesByLocationResponse: Decodable {
    let id: Int
    let dayOfWeek: Int
    let startTime: String
    let endTime: String
    let className: String
}
