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
    // MARK: - Published state
    @Published public var payments: [Payment] = []
    @Published public var isLoading = false
    @Published public var searchText: String = ""
    @Published public var initialDateFilter: Date = Calendar.current.date(from: DateComponents(year: 1990, month: 1, day: 1))!
    @Published public var endDateFilter: Date = .now
    @Published public var selectedPayment: Payment?

    var filteredPayments: [Payment] {
        filterPayments()
    }

    // MARK: - Dependencies
    private let coordinator: (any CoordinatorProtocol)?
    private let toastManager: ToastManager
    private let loadPaymentsUseCase: LoadPayments?

    // MARK: - Init
    init(
        coordinator: (any CoordinatorProtocol)? = nil,
        toastManager: ToastManager = .shared,
        loadPaymentsUseCase: LoadPayments? = nil
    ) {
        self.coordinator = coordinator
        self.toastManager = toastManager
        self.loadPaymentsUseCase = loadPaymentsUseCase
    }

    // MARK: - Use case calls
    func loadPayments() {
        guard let loadPaymentsUseCase else { return }
        Task {
            isLoading = true

            do throws(PaymentsManagementListError) {
                payments = try await loadPaymentsUseCase.execute()
                guard !payments.isEmpty else { throw .noDataFound }
            } catch {
                switch error {
                case .noDataFound:
                    toastManager.showToast(message: "No payments found", type: .error)
                default:
                    toastManager.showToast(message: "Something went wrong", type: .error)
                }
            }

            isLoading = false
        }
    }

    // MARK: - Private methods

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
