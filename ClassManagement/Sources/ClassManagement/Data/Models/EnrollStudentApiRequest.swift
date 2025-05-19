//
//  EnrollStudentApiRequest.swift
//  ClassManagement
//
//  Created by Juan Carlos Hernandez Castillo on 19/05/25.
//

import ClasslyNetworking
import Core

struct EnrollStudentApiRequest: RequestWithBody {
    typealias Response = NoResponse

    var urlMethod: HTTPMethod = .POST
    var endpoint: String { "/payments" }

    var body: EnrollStudentRequestBody

    init(from request: EnrollStudentImpl.Params) {
        self.body = EnrollStudentRequestBody(
            studentId: request.studentId,
            scheduleId: request.scheduleId,
            amount: request.amount,
            paidClasses: request.paidClasses
        )
    }
}

struct EnrollStudentRequestBody: Codable, Sendable {
    let studentId: Int
    let scheduleId: Int
    let amount: Double
    let paidClasses: Int
}
