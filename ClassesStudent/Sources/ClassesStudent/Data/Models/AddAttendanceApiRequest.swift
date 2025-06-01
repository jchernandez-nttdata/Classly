//
//  AddAttendanceApiRequest.swift
//  ClassesStudent
//
//  Created by Juan Carlos Hernandez Castillo on 1/06/25.
//

import ClasslyNetworking
import Core

struct AddAttendanceApiRequest: RequestWithBody {
    typealias Response = NoResponse

    var urlMethod: HTTPMethod = .POST
    var endpoint: String { "/attendances" }

    var body: AddAttendanceRequestBody

    init(userScheduleId: Int, locationId: Int) {
        self.body = AddAttendanceRequestBody(
            userScheduleId: userScheduleId,
            locationId: locationId
        )
    }
}

struct AddAttendanceRequestBody: Codable, Sendable {
    let userScheduleId: Int
    let locationId: Int
}
