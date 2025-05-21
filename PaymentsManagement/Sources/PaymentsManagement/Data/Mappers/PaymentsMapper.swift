//
//  PaymentsMapper.swift
//  PaymentsManagement
//
//  Created by Juan Carlos Hernandez Castillo on 21/05/25.
//

import Core

class PaymentsMapper {
    private static func mapToPayment(response: PaymentResponse) -> Payment {
        return Payment(
            id: response.id,
            studentName: response.studentName,
            amount: response.amount,
            paidClasses: response.paidClasses,
            paymentDate: response.paymentDate.toDate(format: .iso8601),
            classInfo: ClassInfo(
                locationName: response.class.locationName,
                className: response.class.className,
                schedule: Schedule(
                    dayOfWeek: DayOfWeek(rawValue: response.class.schedule.dayOfWeek) ?? .sunday,
                    startTime: response.class.schedule.startTime,
                    endTime: response.class.schedule.endTime
                )
            )
        )
        
    }
    
    static func mapToPayments(responses: [PaymentResponse]) -> [Payment] {
        return responses.map(mapToPayment)
    }
}
