//
//  AddPaymentView.swift
//  PaymentsManagement
//
//  Created by Juan Carlos Hernandez Castillo on 21/05/25.
//

import SwiftUI
import Assets
import UIComponents

struct AddPaymentView: View {
//    @StateObject private var viewModel: EnrollStudentViewModel

//    public init(viewModel: EnrollStudentViewModel) {
//        _viewModel = StateObject(wrappedValue: viewModel)
//    }

    var body: some View {
        VStack {
            CustomAppBar(
                title: "Add payment",
                backAction: {}
            )

            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    CustomSearchableField(
                        placeholder: "Search student",
                        selectedItem: .constant(""),
                        onQueryChanged: { query in
//                            await viewModel.searchStudentNames(query: query)
                            return []
                        }
                    )
                    .padding(.top, 30)

                    CustomSelectableField(
                        selectedItem: .constant(""),
                        items: [],
                        placeholder: "Location",
                        isEnabled: false
                    )

                    CustomSelectableField(
                        selectedItem: .constant(""),
                        items: [],
                        placeholder: "Class",
                        isEnabled: false
                    )

                    CustomSelectableField(
                        selectedItem: .constant(""),
                        items: [],
                        placeholder: "Schedule",
                        isEnabled: false
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
//        .loadingIndicator(viewModel.isLoading)
        .removeFocusOnTap()
    }
}

#Preview {
    AddPaymentView()
}
