//
//  File.swift
//  ClassManagement
//
//  Created by Juan Carlos Hernandez Castillo on 16/05/25.
//

import ClasslyNetworking
import Core

struct UnenrollStudentApiRequest: Request {
    typealias Response = NoResponse

    var urlMethod: HTTPMethod = .DELETE
    var endpoint: String { "/students/\(studentId)/schedules/\(scheduleId)" }

    let studentId: Int
    let scheduleId: Int

    init(studentId: Int, scheduleId: Int) {
        self.scheduleId = scheduleId
        self.studentId = studentId
    }
}
