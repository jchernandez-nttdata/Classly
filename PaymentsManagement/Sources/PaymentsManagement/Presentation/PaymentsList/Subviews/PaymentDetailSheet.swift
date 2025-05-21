//
//  PaymentDetailSheet.swift
//  PaymentsManagement
//
//  Created by Juan Carlos Hernandez Castillo on 20/05/25.
//

import SwiftUI
import Assets
import Core

struct PaymentDetailSheet: View {

    var payment: Payment

    @Environment(\.dismiss) private var dismiss
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Spacer()

                Text(payment.studentName)
                    .font(AppFont.headline)
                    .multilineTextAlignment(.center)

                Spacer()

                Image(systemName: "xmark")
                    .onTapGesture {
                        dismiss()
                    }
            }
            .padding(.vertical, 10)

            Text("Class detail: ")
                .font(AppFont.subheadline.weight(.semibold))
            Text(payment.classInfo.className)
            Text("\(payment.classInfo.schedule.dayOfWeek.description) \(payment.classInfo.schedule.startTime.toAmPmFormat) - \(payment.classInfo.schedule.endTime.toAmPmFormat)")
            Divider()
            Text("Payment detail")
                .font(AppFont.subheadline.weight(.semibold))
            Text("Payment date: \(DateUtils.formatDate(payment.paymentDate ?? .now))")
            Text("Payment time: \(DateUtils.formatTime(payment.paymentDate ?? .now))" )
            Text("Paid classes: \(payment.paidClasses)")
            Text("Amount: $ \(payment.amount.formattedAsCurrency)")

        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
        .padding()
        .presentationDetents([.medium])
    }
}

#Preview {
    PaymentDetailSheet(
        payment: Payment(
            id: 1,
            studentName: "Juan fwef wfe wfewfwefwfw wca",
            amount: 100,
            paidClasses: 4,
            paymentDate: .now,
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

    )
}
