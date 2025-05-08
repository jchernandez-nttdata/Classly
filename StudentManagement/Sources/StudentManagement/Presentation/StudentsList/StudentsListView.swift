//
//  StudentsListView.swift
//  StudentManagement
//
//  Created by Juan Carlos Hernandez Castillo on 6/05/25.
//

import SwiftUI
import UIComponents
import Assets

struct StudentsListView: View {
    @StateObject private var viewModel: StudentsListViewModel

    public init(viewModel: StudentsListViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }

    var body: some View {
        ZStack(alignment: .bottomTrailing) {
            VStack(alignment: .leading) {
                Text("Students")
                    .font(AppFont.largeTitle)
                    .foregroundStyle(AppColor.primaryText)

                CustomTextField(
                    placeholder: "Search",
                    text: .constant(""),
                    leftIcon: Image(systemName: "magnifyingglass"),
                    fieldBackgroundColor: AppColor.secondaryBackground
                )

                List(viewModel.students) { student in
                    StudentTile(student: student) {
                        print("hola amigo")
                    }
                    .listRowInsets(EdgeInsets())
                    .padding(top: 10, bottom: 10)
                }
                .listStyle(.plain)
                .scrollIndicators(.hidden)
                .refreshable {
                    viewModel.loadStudents()
                }
            }
            .padding()

            CircularButton {
                print("add")
            }
        }
        .navigationBarHidden(true)
        .loadingIndicator(viewModel.isLoading)
        .onAppear {
            viewModel.loadStudents()
        }


    }
}

#Preview {
    StudentsListView(viewModel: StudentsListViewModel())
}
