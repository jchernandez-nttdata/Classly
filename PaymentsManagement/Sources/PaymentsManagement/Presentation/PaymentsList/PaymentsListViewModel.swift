//
//  PaymentsListViewModel.swift
//  PaymentsManagement
//
//  Created by Juan Carlos Hernandez Castillo on 20/05/25.
//

import Foundation
import Core

@MainActor
final class PaymentsListViewModel: ObservableObject {
    @Published public var payments: [Payment] = [
        Payment(
            id: 1,
            studentName: "tesxto wrgjoi wegoiwj gwoij g goiejrg ergoij gre",
            amount: 100,
            paidClasses: 8,
            paymentDate: "2024-06-01".toDate(),
            classInfo: ClassInfo(
                locationName: "San Borja",
                className: "Marinera norteña",
                schedule: Schedule(
                    dayOfWeek: .monday,
                    startTime: "9:00",
                    endTime: "10:00"
                )
            )
        ),
        Payment(
            id: 2,
            studentName: "test amigo",
            amount: 100.3,
            paidClasses: 4,
            paymentDate: "2024-05-01".toDate(),
            classInfo: ClassInfo(
                locationName: "San Borja",
                className: "Marinera norteña",
                schedule: Schedule(
                    dayOfWeek: .monday,
                    startTime: "9:00",
                    endTime: "10:00"
                )
            )
        )
    ]
    @Published public var isLoading = false
    @Published public var searchText: String = ""
    @Published public var initialDateFilter: Date = Calendar.current.date(from: DateComponents(year: 1990, month: 1, day: 1))!
    @Published public var endDateFilter: Date = .now
    @Published public var selectedPayment: Payment?

    var filteredPayments: [Payment] {
        filterPayments()
    }

    private let coordinator: (any CoordinatorProtocol)?

    init(
        coordinator: (any CoordinatorProtocol)? = nil
    ) {
        self.coordinator = coordinator
    }

    private func filterPayments() -> [Payment] {
        return payments.filter { payment in
            matchesSearchText(payment) && matchesDateRange(payment)
        }
    }

    private func matchesSearchText(_ payment: Payment) -> Bool {
        guard !searchText.isEmpty else { return true }
        let normalizedSearchText = searchText.folding(options: .diacriticInsensitive, locale: .current).lowercased()
        let normalizedName = payment.studentName.folding(options: .diacriticInsensitive, locale: .current).lowercased()
        return normalizedName.contains(normalizedSearchText)
    }

    private func matchesDateRange(_ payment: Payment) -> Bool {
        guard let paymentDate = payment.paymentDate else { return false }

        let calendar = Calendar.current
        let paymentDay = calendar.startOfDay(for: paymentDate)
        let startDay = calendar.startOfDay(for: initialDateFilter)
        let endDay = calendar.startOfDay(for: endDateFilter)

        return paymentDay >= startDay && paymentDay <= endDay
    }
}
