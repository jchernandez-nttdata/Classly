//
//  PaymentsMapper.swift
//  PaymentsManagement
//
//  Created by Juan Carlos Hernandez Castillo on 21/05/25.
//

import Core

enum PaymentsMapper {
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

    private static func mapToSelectableLocation(response: SelectableLocationResponse) -> SelectableLocation {
        return SelectableLocation(
            id: response.id,
            displayName: response.locationName
        )
    }

    static func mapToSelectableLocations(responses: [SelectableLocationResponse]) -> [SelectableLocation] {
        return responses.map(mapToSelectableLocation)
    }

    private static func mapToSelectableClass(response: SelectableClassResponse) -> SelectableClass {
        return SelectableClass(
            id: response.id,
            displayName: response.className
        )
    }

    static func mapToSelectableClasses(responses: [SelectableClassResponse]) -> [SelectableClass] {
        return responses.map(mapToSelectableClass)
    }

    private static func mapToSelectableSchedule(response: SelectableScheduleResponse) -> SelectableSchedule {
        let dayOfWeek = DayOfWeek(rawValue: response.dayOfWeek) ?? .sunday
        return SelectableSchedule(
            id: response.id,
            displayName: "\(dayOfWeek.description) \(response.startTime.toAmPmFormat) - \(response.endTime.toAmPmFormat)"
        )
    }

    static func mapToSelectableSchedules(responses: [SelectableScheduleResponse]) -> [SelectableSchedule] {
        return responses.map(mapToSelectableSchedule)
    }
}
