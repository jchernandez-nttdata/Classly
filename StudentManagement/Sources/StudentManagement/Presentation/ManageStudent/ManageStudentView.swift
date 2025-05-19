//
//  ManageStudentView.swift
//  StudentManagement
//
//  Created by Juan Carlos Hernandez Castillo on 13/05/25.
//

import SwiftUI
import Assets
import UIComponents

struct ManageStudentView: View {
    @StateObject private var viewModel: ManageStudentViewModel

    public init(viewModel: ManageStudentViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }

    var body: some View {
        VStack {
            CustomAppBar(
                title: viewModel.existingStudent == nil ? "Add Student" : "Edit Student",
                backAction: viewModel.goBack
            )

            ScrollView {
                VStack(spacing: 15) {
                    CustomTextField(
                        placeholder: "Name",
                        text: $viewModel.name
                    )
                    .padding(.top, 30)

                    CustomTextField(
                        placeholder: "Email",
                        text: $viewModel.email,
                        keyboardType: .emailAddress
                    )

                    CustomTextField(
                        placeholder: "DNI",
                        text: $viewModel.dni,
                        keyboardType: .numberPad
                    )

                    CustomTextField(
                        placeholder: "Password \(viewModel.existingStudent == nil ? "" : "(Leave empty to keep current)")",
                        type: .secure,
                        text: $viewModel.password
                    )

                    CustomTextField(
                        placeholder: "Phone",
                        text: $viewModel.phone,
                        keyboardType: .phonePad
                    )

                    CustomDateField(date: $viewModel.birthDate)

                    CustomButton(title: "Save", action: viewModel.save)
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
    ManageStudentView(viewModel: ManageStudentViewModel())
}
