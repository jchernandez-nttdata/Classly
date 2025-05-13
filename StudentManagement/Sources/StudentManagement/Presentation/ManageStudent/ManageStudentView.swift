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
                title: viewModel.existingStudent == nil ? "Add Student" : "Edit Student"
            ) {
                viewModel.goBack()
            }

            Spacer()
        }
        .navigationBarHidden(true)
        .loadingIndicator(viewModel.isLoading)
        .padding()


    }
}

#Preview {
    ManageStudentView(viewModel: ManageStudentViewModel())
}
