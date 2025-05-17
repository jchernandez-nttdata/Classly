//
//  ScheduleDetailView.swift
//  ClassManagement
//
//  Created by Juan Carlos Hernandez Castillo on 15/05/25.
//

import SwiftUI
import UIComponents
import Assets

struct ScheduleDetailView: View {
    @StateObject private var viewModel: ScheduleDetailViewModel

    public init(viewModel: ScheduleDetailViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }

    var body: some View {
        ZStack(alignment: .bottomTrailing) {
            VStack(alignment: .leading, spacing: 20) {
                CustomAppBar(
                    title: "Schedule",
                    backAction: viewModel.goBack
                )

                ClassScheduleCard(
                    classSchedule: viewModel.schedule,
                    studentsEnrolled: viewModel.enrolledStudents.count
                )

                CustomButton(title: "See assistances", style: .outlined) {
                    print("to assistances")
                }

                List(viewModel.enrolledStudents) { student in
                    EnrolledStudentTile(
                        student: student,
                        onDelete: {
                            viewModel.studentToDelete = student.id
                            viewModel.showDeleteConfirmation = true
                        }
                    )
                    .listRowInsets(EdgeInsets())
                    .padding(top: 10, bottom: 10)
                }
                .listStyle(.plain)
                .scrollIndicators(.hidden)
                .refreshable(action: viewModel.loadEnrolledStudents)

            }
            .padding()

            CircularButton(onTap: viewModel.goToEnrollStudent)
        }
        .navigationBarHidden(true)
        .loadingIndicator(viewModel.isLoading)
        .onAppear(perform: viewModel.loadEnrolledStudents)
        .sheet(isPresented: $viewModel.showDeleteConfirmation, onDismiss: {
            viewModel.studentToDelete = nil
        }) {
            if let studentId = viewModel.studentToDelete {
                AlertSheet(
                    title: "Unenroll student?",
                    message: "This action cannot be undone. The student will be removed from the class",
                    onConfirm: {
                        viewModel.unenrollStudent(studentId: studentId)
                    }
                )
            }
        }
    }
}

#Preview {
    ScheduleDetailView(
        viewModel: ScheduleDetailViewModel(
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
