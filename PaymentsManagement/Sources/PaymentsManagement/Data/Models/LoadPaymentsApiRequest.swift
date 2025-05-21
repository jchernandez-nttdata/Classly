//
//  LoadPaymentsApiRequest.swift
//  PaymentsManagement
//
//  Created by Juan Carlos Hernandez Castillo on 21/05/25.
//

import ClasslyNetworking

struct LoadPaymentsApiRequest: Request {
    typealias Response = [PaymentResponse]

    var urlMethod: HTTPMethod = .GET
    var endpoint: String = "/payments"

}

struct PaymentResponse: Decodable {
    let id: Int
    let studentName: String
    let amount: Double
    let paidClasses: Int
    let paymentDate: String
    let `class` : ClassInfoResponse
}

struct ClassInfoResponse: Decodable {
    let locationName: String
    let className: String
    let schedule: ScheduleResponse
}

struct ScheduleResponse: Decodable {
    let dayOfWeek: Int
    let startTime: String
    let endTime: String
}
