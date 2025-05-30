//
//  LoadStudentClassesApiRequest.swift
//  ClassesStudent
//
//  Created by Juan Carlos Hernandez Castillo on 29/05/25.
//

import ClasslyNetworking

struct LoadStudentClassesApiRequest: Request {
    typealias Response = [StudentClassResponse]

    var urlMethod: HTTPMethod = .GET
    var endpoint: String { "/students/\(studentId)/schedules" }

    var studentId: Int
}

struct StudentClassResponse: Decodable {
    let userScheduleId: Int
    let className: String
    let locationName: String
    let dayOfWeek: Int
    let startTime: String
    let endTime: String
    let attendanceRecorded: Bool
    let remainingClasses: Int
}
