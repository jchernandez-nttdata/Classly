//
//  ClassListView.swift
//  ClassesStudent
//
//  Created by Juan Carlos Hernandez Castillo on 28/05/25.
//

import SwiftUI
import UIComponents
import Assets

struct ClassListView: View {
//    @StateObject private var viewModel: PaymentsListViewModel

//    public init(viewModel: PaymentsListViewModel) {
//        _viewModel = StateObject(wrappedValue: viewModel)
//    }

    var body: some View {
        VStack(alignment: .leading, spacing: 15) {
            CustomAppBar(title: "Classes")

            CustomButton(title: "Register Attendance") {
                print("go to attendance")
            }

        }
        .padding()
        .navigationBarHidden(true)
//        .loadingIndicator(viewModel.isLoading)
        .onAppear {
//            if !didLoadPayments {
//                viewModel.loadPayments()
//                didLoadPayments = true
//            }
        }
    }
}

#Preview {
    ClassListView()
}
