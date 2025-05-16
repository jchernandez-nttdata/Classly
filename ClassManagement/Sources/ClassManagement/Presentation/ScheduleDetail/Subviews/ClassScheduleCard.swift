//
//  ClassScheduleCard.swift
//  ClassManagement
//
//  Created by Juan Carlos Hernandez Castillo on 15/05/25.
//

import SwiftUI
import Assets
import UIComponents

struct ClassScheduleCard: View {
    let classSchedule: ClassSchedule
    let studentsEnrolled: Int

    var body: some View {
        CustomCard {
            VStack(alignment: .leading, spacing: 6) {
                HStack {
                    Text(classSchedule.className)
                        .font(AppFont.body.bold())
                    Spacer()
                    Text(classSchedule.locationName)
                        .font(AppFont.body)
                }

                Text("\(classSchedule.startTime.toAmPmFormat) - \(classSchedule.endTime.toAmPmFormat)")
                    .font(AppFont.body)
                Text("Students enrolled: \(studentsEnrolled)")
                    .font(AppFont.body)
            }
        }
    }
}

#Preview {
    ClassScheduleCard(
        classSchedule: ClassSchedule(
            id: 1,
            dayOfWeek: .monday,
            startTime: "9:00",
            endTime: "10:00",
            className: "Marinera",
            locationName: "San Borja"
        ),
        studentsEnrolled: 4
    )
}
