//
//  EnrollStudentView.swift
//  ClassManagement
//
//  Created by Juan Carlos Hernandez Castillo on 13/05/25.
//

import SwiftUI
import Assets
import UIComponents
import Core

struct EnrollStudentView: View {
    @StateObject private var viewModel: EnrollStudentViewModel

    public init(viewModel: EnrollStudentViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }

    var body: some View {
        VStack {
            CustomAppBar(
                title: "Enroll student",
                backAction: viewModel.goBack
            )

            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    CustomSearchableField(
                        placeholder: "Search student",
                        selectedItem: $viewModel.selectedStudent,
                        onQueryChanged: { query in
                            await viewModel.searchStudentNames(query: query)
                        }
                    )
                    .padding(.top, 30)

                    HStack(alignment: .top) {
                        Image(systemName: "info.circle")
                            .foregroundColor(AppColor.secondaryText)
                            .frame(width: 15, height: 15)
                            .padding(top: 5, right: 5)

                        Text("Already enrolled students will have new classes added.")
                            .font(AppFont.caption)
                            .foregroundStyle(AppColor.secondaryText)

                    }
                    .padding(top: -15, left: 5)

                    CustomSelectableField(
                        selectedItem: .constant(EmptySelectableItem(name: viewModel.schedule.locationName)),
                        items: [],
                        placeholder: "Location",
                        isEnabled: false
                    )

                    CustomSelectableField(
                        selectedItem: .constant(EmptySelectableItem(name: viewModel.schedule.className)),
                        items: [],
                        placeholder: "Class",
                        isEnabled: false
                    )

                    CustomSelectableField(
                        selectedItem: .constant(EmptySelectableItem(name: "\(viewModel.schedule.dayOfWeek.description) | \(viewModel.schedule.startTime.toAmPmFormat) - \(viewModel.schedule.endTime.toAmPmFormat)")),
                        items: [],
                        placeholder: "Schedule",
                        isEnabled: false
                    )

                    CustomTextField(
                        placeholder: "Number of classes",
                        text: $viewModel.paidClassesString,
                        keyboardType: .numberPad
                    )

                    CustomTextField(
                        placeholder: "Amount",
                        text: $viewModel.amountString,
                        leftIcon: Image(systemName: "dollarsign"),
                        keyboardType: .decimalPad
                    )

                    Spacer(minLength: 30)

                    CustomButton(title: "Confirm", action: viewModel.enrollStudent)
                }
            }
        }
        .padding()
        .navigationBarHidden(true)
        .loadingIndicator(viewModel.isLoading)
        .removeFocusOnTap()
    }
}

#Preview {
    EnrollStudentView(
        viewModel: EnrollStudentViewModel(
            schedule: ClassSchedule(
                id: 1,
                dayOfWeek: .thursday,
                startTime: "9:00",
                endTime: "10:00",
                className: "Marinera norteña",
                locationName: "San Borja"
            )
        )
    )
}
