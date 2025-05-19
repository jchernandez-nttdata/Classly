//
//  AssistancesView.swift
//  ClassManagement
//
//  Created by Juan Carlos Hernandez Castillo on 16/05/25.
//

import SwiftUI
import UIComponents
import Assets
import Core

struct AssistancesView: View {
    @StateObject private var viewModel: AssistancesViewModel

    public init(viewModel: AssistancesViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }

    let students = ["Juan", "Pedro", "María", "Sofía", "Pablo", "Laura"]

    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            CustomAppBar(
                title: "Assistances",
                backAction: viewModel.goBack
            )

            ClassScheduleCard(
                classSchedule: viewModel.schedule,
                studentsEnrolled: 0
            )

            List(viewModel.attendancesDates, id: \.self) { date in
                AssistanceDateTile(
                    date: DateUtils.formatDate(date.toDate() ?? .now),
                    onSelect: {
                        viewModel.loadStudentAttendances(for: date.toDate() ?? .now)
                    }
                )
                .listRowInsets(EdgeInsets())
                .padding(.vertical, 10)
            }
            .listStyle(.plain)
            .scrollIndicators(.hidden)
            .refreshable(action: {})

        }
        .padding()
        .navigationBarHidden(true)
        .loadingIndicator(viewModel.isLoading)
        .onAppear(perform: viewModel.loadAttendancesDates)
        .sheet(isPresented: $viewModel.showAttendancesSheet, onDismiss: {

        }) {
            StudentAttendanceSheet(
                isLoading: $viewModel.isAttendancesLoading,
                students: $viewModel.studentAttendances,
                title: viewModel.selectedDate
            )

        }
    }
}

#Preview {
    AssistancesView(
        viewModel: AssistancesViewModel(
            schedule: ClassSchedule(
                id: 1,
                dayOfWeek: .friday,
                startTime: "9:00",
                endTime: "10:00",
                className: "Marinera Norteña",
                locationName: "San Borja"
            )
        )
    )
}
