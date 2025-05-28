//
//  SwiftUIView.swift
//  ClassesStudent
//
//  Created by Juan Carlos Hernandez Castillo on 28/05/25.
//

import SwiftUI
import Assets

struct ScheduleClassCard: View {
    let studentClass: StudentClass
    let onRegisterAttendance: () -> Void

    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            Text("\(studentClass.className) - \(studentClass.locationName)")
                .font(AppFont.body.bold())
            Text("\(studentClass.startTime.toAmPmFormat) - \(studentClass.endTime.toAmPmFormat)")
            Text("\(studentClass.remainingClasses) remaining classes")
            if studentClass.attendanceRecorded {
                Text("Attendance registered")
                    .font(AppFont.body.bold())
                    .foregroundStyle(AppColor.brandPrimary)
            } else {
                HStack {
                    Image(systemName: "qrcode")
                        .foregroundStyle(AppColor.warning)

                    Text("Scan attendance")
                        .font(AppFont.body.bold())
                        .foregroundStyle(AppColor.warning)
                        .underline()
                }
                .padding(top: 5)
                .onTapGesture(perform: onRegisterAttendance)
            }
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
        .overlay(
            RoundedRectangle(cornerRadius: 12)
                .stroke(AppColor.border, lineWidth: 1)
        )
        .listRowInsets(EdgeInsets())
        .listRowSeparator(.hidden)
        .padding(top: 10, bottom: 10)
    }
}

#Preview {
    VStack {
        ScheduleClassCard(
            studentClass: StudentClass(
                userScheduleId: 1,
                className: "Marinera Norteña",
                locationName: "San Borja",
                dayOfWeek: .saturday,
                startTime: "9:00",
                endTime: "10:00",
                attendanceRecorded: true,
                remainingClasses: 3
            ),
            onRegisterAttendance: {}
        )
        ScheduleClassCard(
            studentClass: StudentClass(
                userScheduleId: 1,
                className: "Marinera Norteña",
                locationName: "San Borja",
                dayOfWeek: .saturday,
                startTime: "9:00",
                endTime: "10:00",
                attendanceRecorded: false,
                remainingClasses: 3
            ),
            onRegisterAttendance: {}
        )
    }
    .padding()
}
