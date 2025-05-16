//
//  ScheduleStudentTile.swift
//  ClassManagement
//
//  Created by Juan Carlos Hernandez Castillo on 15/05/25.
//

import SwiftUI
import Assets

struct ScheduleStudentTile: View {
    let student: ScheduleStudent
    let onDelete: () -> Void

    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text("\(student.name)")
                    .font(AppFont.body.bold())
                    .padding(.bottom, 1)

                Text("DNI: \(student.dni) / \(student.phone)")
                    .font(AppFont.body)

                Text("Remaining classes: \(student.remainingClasses)")
                    .font(AppFont.body)
            }

            Spacer()

            Image(systemName: "trash.fill")
                .onTapGesture(perform: onDelete)
        }
    }
}

#Preview {
    ScheduleStudentTile(
        student: ScheduleStudent(
            id: 1,
            name: "name",
            email: "email",
            dni: "dni",
            phone: "93283",
            remainingClasses: 3
        ),
        onDelete: {}
    )
}
