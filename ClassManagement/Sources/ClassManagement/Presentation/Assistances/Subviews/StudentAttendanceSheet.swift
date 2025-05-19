//
//  StudentAttendanceSheet.swift
//  ClassManagement
//
//  Created by Juan Carlos Hernandez Castillo on 19/05/25.
//

import SwiftUI
import Assets

struct StudentAttendanceSheet: View {

    @Binding var isLoading: Bool
    @Binding var students: [StudentAttendance]
    var title: String

    @Environment(\.dismiss) private var dismiss
    var body: some View {
        VStack(spacing: 20) {
            HStack {
                Spacer()

                Text(title)
                    .font(AppFont.headline)
                    .multilineTextAlignment(.center)

                Spacer()

                Image(systemName: "xmark")
                    .onTapGesture {
                        dismiss()
                    }
            }

            List(students) { student in
                VStack(alignment: .leading) {
                    Text(student.name)
                        .padding(.bottom, 3)
                        .font(AppFont.body.bold())

                    Text(student.registrationDate.toAmPmFormat)
                        .font(AppFont.body)
                }
                .listRowInsets(EdgeInsets())
                .padding(.vertical, 10)
            }
            .listStyle(.plain)
            .scrollIndicators(.hidden)

        }
        .padding()
        .presentationDetents([.medium])
        .overlay {
            if isLoading {
                ProgressView()
            }
        }
    }
}

#Preview {
    StudentAttendanceSheet(
        isLoading: .constant(true),
        students: .constant([
            StudentAttendance(studentId: 1, name: "Juan Pérez", registrationDate: .now),
            StudentAttendance(studentId: 2, name: "wefwef wefwefw fwefwefwef", registrationDate: .now),
            StudentAttendance(studentId: 3, name: "AAAAAA", registrationDate: .now),
            StudentAttendance(studentId: 4, name: "efwefw", registrationDate: .now),
            StudentAttendance(studentId: 5, name: "wefwefw wefwef", registrationDate: .now)
        ]),
        title: "Monday, 7 april"
    )
}
