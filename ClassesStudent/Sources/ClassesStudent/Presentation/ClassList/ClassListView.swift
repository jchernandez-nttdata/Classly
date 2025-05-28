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
//    @StateObject private var viewModel: PaymentsListViewModel

//    public init(viewModel: PaymentsListViewModel) {
//        _viewModel = StateObject(wrappedValue: viewModel)
//    }

    let classes: [StudentClass] = [
        StudentClass(userScheduleId: 1, className: "Marinera Norteña", locationName: "San Borja", dayOfWeek: .monday, startTime: "9:00", endTime: "10:00", attendanceRecorded: true, remainingClasses: 3),
        StudentClass(userScheduleId: 2, className: "Marinera Norteña", locationName: "San Borja", dayOfWeek: .monday, startTime: "10:00", endTime: "11:00", attendanceRecorded: false, remainingClasses: 3),
        StudentClass(userScheduleId: 3, className: "Danza", locationName: "San Borja", dayOfWeek: .monday, startTime: "20:00", endTime: "21:00", attendanceRecorded: false, remainingClasses: 3),
        StudentClass(userScheduleId: 4, className: "Marinera Limeña", locationName: "San Borja", dayOfWeek: .friday, startTime: "9:00", endTime: "10:00", attendanceRecorded: false, remainingClasses: 3),
        StudentClass(userScheduleId: 5, className: "Marinera Norteña", locationName: "San Borja", dayOfWeek: .saturday, startTime: "9:00", endTime: "10:00", attendanceRecorded: false, remainingClasses: 3),
        StudentClass(userScheduleId: 6, className: "Marinera Limeña", locationName: "San Borja", dayOfWeek: .saturday, startTime: "19:00", endTime: "20:00", attendanceRecorded: true, remainingClasses: 3),
    ]

    var orderedClasses: [(key: DayOfWeek, value: [StudentClass])] {
        classes.sortedGroupedByDay()
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 15) {
            CustomAppBar(title: "Classes")

            List {
                ForEach(orderedClasses, id: \.key) { dayGroup in
                    SectionTitle(title: dayGroup.key.description)
                        .padding(top: 15)
                    ForEach(dayGroup.value) { studentClass in
                        ScheduleClassCard(
                            studentClass: studentClass,
                            onRegisterAttendance: {}
                        )

                    }
                }
                .listRowInsets(EdgeInsets())
            }
            .listStyle(.plain)
            .scrollIndicators(.hidden)
            .refreshable {
                //                viewModel.loadLocations()
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
