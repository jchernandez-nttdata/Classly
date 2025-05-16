//
//  LoadEnrolledStudentsByScheduleApiRequest.swift
//  ClassManagement
//
//  Created by Juan Carlos Hernandez Castillo on 15/05/25.
//

import ClasslyNetworking

struct LoadEnrolledStudentsByScheduleApiRequest: Request {
    typealias Response = [LoadEnrolledStudentsByScheduleResponse]

    var urlMethod: HTTPMethod = .GET
    var endpoint: String { "/schedules/\(scheduleId)/students" }

    var scheduleId: Int
}

struct LoadEnrolledStudentsByScheduleResponse: Decodable {
    let id: Int
    let name: String
    let email: String
    let dni: String
    let phone: String
    let remainingClasses: Int
}
