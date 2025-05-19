//
//  LoadStudentAttendancesApiRequest.swift
//  ClassManagement
//
//  Created by Juan Carlos Hernandez Castillo on 19/05/25.
//

import ClasslyNetworking

struct LoadStudentAttendancesApiRequest: Request {
    typealias Response = [LoadStudentAttendancesResponse]

    var urlMethod: HTTPMethod = .GET
    var endpoint: String { "/schedules/\(scheduleId)/attendances" }
    var params: [String: String]?

    var scheduleId: Int

    init(
        scheduleId: Int,
        date: String
    ) {
        self.scheduleId = scheduleId
        self.params = ["date": date]
    }
}

struct LoadStudentAttendancesResponse: Decodable {
    let studentId: Int
    let name: String
    let registrationDate: String
}
