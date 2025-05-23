//
//  AddPaymentApiRequest.swift
//  PaymentsManagement
//
//  Created by Juan Carlos Hernandez Castillo on 21/05/25.
//

import ClasslyNetworking
import Core

struct AddPaymentApiRequest: RequestWithBody {
    typealias Response = NoResponse

    var urlMethod: HTTPMethod = .POST
    var endpoint: String { "/payments" }

    var body: AddPaymentApiRequestRequestBody

    init(from request: AddPaymentImpl.Params) {
        self.body = AddPaymentApiRequestRequestBody(
            studentId: request.studentId,
            scheduleId: request.scheduleId,
            amount: request.amount,
            paidClasses: request.paidClasses
        )
    }
}

struct AddPaymentApiRequestRequestBody: Codable, Sendable {
    let studentId: Int
    let scheduleId: Int
    let amount: Double
    let paidClasses: Int
}
