//
//  ClassListView.swift
//  ClassesStudent
//
//  Created by Juan Carlos Hernandez Castillo on 28/05/25.
//

import SwiftUI
import UIComponents
import Assets
import Core

struct ClassListView: View {
    @StateObject private var viewModel: ClassListViewModel

    public init(viewModel: ClassListViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 15) {
            CustomAppBar(title: "Classes")

            List {
                ForEach(viewModel.studentClasses.sortedGroupedByDay(), id: \.key) { dayGroup in
                    SectionTitle(title: dayGroup.key.description)
                        .padding(top: 15)
                    ForEach(dayGroup.value) { studentClass in
                        ScheduleClassCard(
                            studentClass: studentClass,
                            onRegisterAttendance: {
                                viewModel.toQRScan(studentClass: studentClass)
                            }
                        )

                    }
                }
                .listRowInsets(EdgeInsets())
            }
            .listStyle(.plain)
            .scrollIndicators(.hidden)
            .refreshable {
                viewModel.loadStudentsClasses()
            }

        }
        .padding()
        .navigationBarHidden(true)
        .loadingIndicator(viewModel.isLoading)
        .onAppear {
            viewModel.loadStudentsClasses()
        }
    }
}

#Preview {
    ClassListView(viewModel: ClassListViewModel())
}
