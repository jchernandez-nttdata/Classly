//
//  AddPaymentView.swift
//  PaymentsManagement
//
//  Created by Juan Carlos Hernandez Castillo on 21/05/25.
//

import SwiftUI
import Assets
import UIComponents
import Core

struct AddPaymentView: View {
    @StateObject private var viewModel: AddPaymentViewModel

    public init(viewModel: AddPaymentViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }

    var body: some View {
        VStack {
            CustomAppBar(
                title: "Add payment",
                backAction: viewModel.goBack
            )

            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    CustomSearchableField(
                        placeholder: "Search student",
                        selectedItem: $viewModel.selectedStudent,
                        onQueryChanged: { query in
                            return await viewModel.searchStudentNames(query: query)
                        }
                    )
                    .padding(.top, 30)

                    CustomSelectableField(
                        selectedItem: $viewModel.selectedLocation,
                        items: viewModel.locations,
                        placeholder: "Location"
                    )

                    CustomSelectableField(
                        selectedItem: $viewModel.selectedClass,
                        items: viewModel.classes,
                        placeholder: "Class",
                        isEnabled: !viewModel.classes.isEmpty
                    )

                    CustomSelectableField(
                        selectedItem: $viewModel.selectedSchedule,
                        items: viewModel.schedules,
                        placeholder: "Schedule",
                        isEnabled: !viewModel.schedules.isEmpty
                    )

                    CustomTextField(
                        placeholder: "Number of classes",
                        text: .constant(""),
                        keyboardType: .numberPad
                    )

                    CustomTextField(
                        placeholder: "Amount",
                        text: .constant(""),
                        leftIcon: Image(systemName: "dollarsign"),
                        keyboardType: .decimalPad
                    )

                    Spacer(minLength: 30)

                    CustomButton(title: "Confirm", action: {})
                }
            }
        }
        .padding()
        .navigationBarHidden(true)
        .loadingIndicator(viewModel.isLoading)
        .onAppear {
            viewModel.loadSelectableLocations()
        }
        .removeFocusOnTap()
    }
}

#Preview {
    AddPaymentView(viewModel: AddPaymentViewModel())
}
