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

    let list = [
        EnrolledStudent(id: 1, name: "Juanca", email: "email@email.com", dni: "838838", phone: "982323", remainingClasses: 3),
        EnrolledStudent(id: 2, name: "Juanca", email: "email@email.com", dni: "838838", phone: "982323", remainingClasses: 3),
        EnrolledStudent(id: 3, name: "Juanca", email: "email@email.com", dni: "838838", phone: "982323", remainingClasses: 3),
        EnrolledStudent(id: 4, name: "Juanca", email: "email@email.com", dni: "838838", phone: "982323", remainingClasses: 3),
        EnrolledStudent(id: 5, name: "Juanca", email: "email@email.com", dni: "838838", phone: "982323", remainingClasses: 3),
        EnrolledStudent(id: 6, name: "Juanca", email: "email@email.com", dni: "838838", phone: "982323", remainingClasses: 3),
        EnrolledStudent(id: 7, name: "Juanca", email: "email@email.com", dni: "838838", phone: "982323", remainingClasses: 3)
    ]

    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            CustomAppBar(
                title: "Schedule",
                backAction: viewModel.goBack
            )

            ClassScheduleCard(
                classSchedule: viewModel.schedule,
                studentsEnrolled: list.count
            )

            CustomButton(title: "See assistances", style: .outlined) {
                print("to assistances")
            }

            List(list) { student in
                EnrolledStudentTile(
                    student: student,
                    onDelete: {
                        print("delete")
                    }
                )
                .listRowInsets(EdgeInsets())
                .padding(top: 10, bottom: 10)
            }
            .listStyle(.plain)
            .scrollIndicators(.hidden)
            .refreshable {

            }

        }
        .padding()
        .navigationBarHidden(true)
        //        .loadingIndicator(viewModel.isLoading)
        .onAppear {

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
