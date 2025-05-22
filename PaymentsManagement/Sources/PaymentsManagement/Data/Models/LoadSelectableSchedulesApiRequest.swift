//
//  LoadSelectableSchedulesApiRequest.swift
//  PaymentsManagement
//
//  Created by Juan Carlos Hernandez Castillo on 21/05/25.
//

import ClasslyNetworking

struct LoadSelectableSchedulesApiRequest: Request {
    typealias Response = [SelectableScheduleResponse]

    var urlMethod: HTTPMethod = .GET
    var endpoint: String { "/classes/\(classId)/schedules" }

    var classId: Int
}

struct SelectableScheduleResponse: Decodable {
    let id: Int
    let dayOfWeek: Int
    let startTime: String
    let endTime: String
}
