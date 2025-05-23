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
    @StateObject private var viewModel: PaymentsListViewModel
    @State private var didLoadPayments = false

    public init(viewModel: PaymentsListViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 15) {
            CustomAppBar(title: "Payments")

            CustomTextField(
                placeholder: "Search",
                text: $viewModel.searchText,
                leftIcon: Image(systemName: "magnifyingglass"),
                fieldBackgroundColor: AppColor.secondaryBackground
            )

            CustomDateRangeField(
                startDate: $viewModel.initialDateFilter,
                endDate: $viewModel.endDateFilter
            )

            CustomButton(title: "Add payment", action: viewModel.toAddPayment)

            List(viewModel.filteredPayments) { payment in
                PaymentTile(payment: payment) {
                    viewModel.selectedPayment = payment
                }
                .listRowInsets(EdgeInsets())
                .padding(top: 10, bottom: 10)
            }
            .listStyle(.plain)
            .scrollIndicators(.hidden)
            .refreshable {
                viewModel.loadPayments()
            }
        }
        .padding()
        .navigationBarHidden(true)
        .removeFocusOnTap()
        .loadingIndicator(viewModel.isLoading)
        .onAppear {
            if !didLoadPayments {
                viewModel.loadPayments()
                didLoadPayments = true
            }
        }
        .sheet(item: $viewModel.selectedPayment) { payment in
            PaymentDetailSheet(payment: payment)
        }
    }
}

#Preview {
    PaymentsListView(viewModel: PaymentsListViewModel())
}
