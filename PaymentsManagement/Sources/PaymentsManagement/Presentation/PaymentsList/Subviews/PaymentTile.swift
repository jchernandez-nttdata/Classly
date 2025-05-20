//
//  File.swift
//  PaymentsManagement
//
//  Created by Juan Carlos Hernandez Castillo on 20/05/25.
//

import SwiftUI
import Assets
import Core

struct PaymentTile: View {
    let payment: Payment
    let onSelect: () -> Void

    private var dateString: String {
        guard let date = payment.paymentDate else { return "--" }
        return DateUtils.formatDate(date)
    }

    var body: some View {
        VStack {
            HStack {
                Text(payment.studentName)
                    .lineLimit(1)           
                    .truncationMode(.tail)
                
                Spacer()

                Text("$ \(payment.amount.formattedAsCurrency)")
            }
            .font(AppFont.body.bold())
            .padding(.bottom, 1)

            HStack {
                Text(dateString)

                Spacer()

                Text("\(payment.paidClasses) classes")
            }
            .font(AppFont.body)
        }
        .frame(maxWidth: .infinity)
        .contentShape(Rectangle())
        .onTapGesture(perform: onSelect)
    }
}

#Preview {
    PaymentTile(
        payment: Payment(
            id: 1,
            studentName: "Test name",
            amount: 20.0,
            paidClasses: 4,
            paymentDate: .now
        ),
        onSelect: {
        }
    )
}
