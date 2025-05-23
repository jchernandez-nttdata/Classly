//
//  AddPayment.swift
//  PaymentsManagement
//
//  Created by Juan Carlos Hernandez Castillo on 21/05/25.
//

protocol AddPayment {
    func execute(params: AddPaymentImpl.Params) async throws(AddPaymentError)
}

final class AddPaymentImpl: AddPayment {
    private let repository: PaymentsRepository

    struct Params {
        let studentId: Int
        let scheduleId: Int
        let amount: Double
        let paidClasses: Int
    }

    init(repository: PaymentsRepository) {
        self.repository = repository
    }

    func execute(params: AddPaymentImpl.Params) async throws(AddPaymentError) {
        return try await repository.addPayment(params: params)
    }
}
