//
//  LoadAttendancesDatesApiRequest.swift
//  ClassManagement
//
//  Created by Juan Carlos Hernandez Castillo on 19/05/25.
//

import ClasslyNetworking

struct LoadAttendancesDatesApiRequest: Request {
    typealias Response = [String]

    var urlMethod: HTTPMethod = .GET
    var endpoint: String { "/schedules/\(scheduleId)/attendances/dates" }

    var scheduleId: Int
}
