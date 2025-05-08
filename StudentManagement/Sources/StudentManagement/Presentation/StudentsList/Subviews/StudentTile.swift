//
//  StudentTile.swift
//  StudentManagement
//
//  Created by Juan Carlos Hernandez Castillo on 7/05/25.
//

import SwiftUI
import Assets

struct StudentTile: View {
    let student: Student
    let onEdit: () -> Void

    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text("\(student.name)")
                    .font(AppFont.body.bold())
                    .padding(.bottom, 1)

                Text("DNI: \(student.dni) - \(student.phone)")
                    .font(AppFont.body)
            }

            Spacer()

            Image(systemName: "pencil")
                .onTapGesture(perform: onEdit)
        }
    }
}

#Preview {
    StudentTile(
        student: Student(
            id: 1,
            name: "Juanca",
            email: "email1@example.com",
            dni: "12345678",
            phone: "987654321",
            birthDate: Date.now
        ),
        onEdit: {}
    )
}
