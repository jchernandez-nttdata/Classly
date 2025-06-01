//
//  File.swift
//  ClassesStudent
//
//  Created by Juan Carlos Hernandez Castillo on 1/06/25.
//

import SwiftUI
import UIComponents
import Assets
import Core

struct SuccessAttendanceView: View {

    private let coordinator: (any CoordinatorProtocol)?
    private let userSchedule: StudentClass
    public init(
        coordinator: (any CoordinatorProtocol)? = nil,
        userSchedule: StudentClass
    ) {
        self.coordinator = coordinator
        self.userSchedule = userSchedule
    }

    var body: some View {
        VStack(spacing: 0) {

            Spacer()
            VStack() {
                CircularButton(onTap: {}, systemName: "checkmark")
                
                Text("Attendance Registered")
                    .font(AppFont.title)
                    .padding(.bottom)

                Text(userSchedule.className)
                    .font(AppFont.subheadline)
                    .padding(.bottom, 3)

                Text(userSchedule.locationName)
                    .font(AppFont.subheadline)
                    .padding(.bottom, 3)
                
                Text("\(userSchedule.dayOfWeek.description) - \(userSchedule.startTime.toAmPmFormat) ")
                    .font(AppFont.subheadline)
            }
            Spacer()
            CustomButton(title: "Done") {
                guard let coordinator = coordinator as? ClassesStudentCoordinator else { return }
                coordinator.popToRoot()
            }
        }
        .navigationBarHidden(true)
        .padding()
    }
}

#Preview {
    SuccessAttendanceView(
        userSchedule: StudentClass(
            userScheduleId: 1,
            className: "Marinera Norteña",
            locationName: "San Borja",
            dayOfWeek: .friday,
            startTime: "9:00",
            endTime: "10:00",
            attendanceRecorded: true,
            remainingClasses: 10
        )
    )
}
