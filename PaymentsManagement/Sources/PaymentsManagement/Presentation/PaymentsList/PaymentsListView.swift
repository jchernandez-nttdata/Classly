//
//  PaymentsListView.swift
//  PaymentsManagement
//
//  Created by Juan Carlos Hernandez Castillo on 20/05/25.
//

import SwiftUI
import UIComponents
import Assets

struct PaymentsListView: View {
    let payments = [
        Payment(id: 1, studentName: "tesxto wrgjoi wegoiwj gwoij g goiejrg ergoij gre", amount: 100, paidClasses: 8, paymentDate: .now),
        Payment(id: 2, studentName: "test amigo", amount: 100.3, paidClasses: 4, paymentDate: .now)
    ]

    @State private var initialDate: Date = Calendar.current.date(from: DateComponents(year: 1990, month: 1, day: 1))!
    @State private var endDate: Date = .now

    var body: some View {
        VStack(alignment: .leading, spacing: 15) {
            CustomAppBar(title: "Payments")

            CustomTextField(
                placeholder: "Search",
                text: .constant(""),
                leftIcon: Image(systemName: "magnifyingglass"),
                fieldBackgroundColor: AppColor.secondaryBackground
            )

            CustomDateRangeField(
                startDate: $initialDate,
                endDate: $endDate
            )

            CustomButton(title: "Register payment") {
                print("to register payment")
            }

            List(payments) { payment in
                PaymentTile(payment: payment) {
                    print("show payment")
                }
                .listRowInsets(EdgeInsets())
                .padding(top: 10, bottom: 10)
            }
            .listStyle(.plain)
            .scrollIndicators(.hidden)
            .refreshable {
//                viewModel.loadStudents()
            }
        }
        .padding()
        .navigationBarHidden(true)
//        .loadingIndicator(viewModel.isLoading)
        .onAppear {
//            if !didLoadStudents {
//                viewModel.loadStudents()
//                didLoadStudents = true
//            }
        }
    }
}

#Preview {
    PaymentsListView()
}
