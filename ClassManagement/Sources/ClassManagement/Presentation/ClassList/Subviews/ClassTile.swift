//
//  ClassTile.swift
//  ClassManagement
//
//  Created by Juan Carlos Hernandez Castillo on 14/05/25.
//

import SwiftUI
import Assets

struct ClassTile: View {
    let classSchedule: ClassSchedule
    let onSelect: () -> Void

    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text("\(classSchedule.className)")
                    .font(AppFont.body.bold())
                    .padding(.bottom, 1)

                Text("\(classSchedule.dayOfWeek.description), \(classSchedule.startTime) - \(classSchedule.endTime)")
                    .font(AppFont.body)
            }

            Spacer()

            Image(systemName: "chevron.right")
        }
        .onTapGesture(perform: onSelect)
    }
}

#Preview {
    ClassTile(
        classSchedule: ClassSchedule(
            id: 1,
            dayOfWeek: .saturday,
            startTime: "10:00",
            endTime: "11:00",
            className: "Marinera Norteña"
        ),
        onSelect: {}
    )
}
