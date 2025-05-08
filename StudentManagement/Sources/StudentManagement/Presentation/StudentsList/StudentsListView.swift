//
//  StudentsListView.swift
//  StudentManagement
//
//  Created by Juan Carlos Hernandez Castillo on 6/05/25.
//

import SwiftUI
import UIComponents
import Assets

struct StudentsListView: View {
    let data = [
        Student(id: 1, name: "Juanca", email: "email1@example.com", dni: "12345678", phone: "987654321", birthDate: Date.now),
        Student(id: 1, name: "Juanca", email: "email1@example.com", dni: "12345678", phone: "987654321", birthDate: Date.now),
        Student(id: 1, name: "Juanca", email: "email1@example.com", dni: "12345678", phone: "987654321", birthDate: Date.now),
        Student(id: 1, name: "Juanca", email: "email1@example.com", dni: "12345678", phone: "987654321", birthDate: Date.now),
        Student(id: 1, name: "Juanca", email: "email1@example.com", dni: "12345678", phone: "987654321", birthDate: Date.now),
        Student(id: 1, name: "Juanca", email: "email1@example.com", dni: "12345678", phone: "987654321", birthDate: Date.now),
        Student(id: 1, name: "Juanca", email: "email1@example.com", dni: "12345678", phone: "987654321", birthDate: Date.now),
        Student(id: 1, name: "Juanca", email: "email1@example.com", dni: "12345678", phone: "987654321", birthDate: Date.now),
        Student(id: 1, name: "Juanca", email: "email1@example.com", dni: "12345678", phone: "987654321", birthDate: Date.now),
        Student(id: 1, name: "Juanca", email: "email1@example.com", dni: "12345678", phone: "987654321", birthDate: Date.now),
        Student(id: 1, name: "Juanca", email: "email1@example.com", dni: "12345678", phone: "987654321", birthDate: Date.now),
        Student(id: 1, name: "Juanca", email: "email1@example.com", dni: "12345678", phone: "987654321", birthDate: Date.now),
        Student(id: 1, name: "Juanca", email: "email1@example.com", dni: "12345678", phone: "987654321", birthDate: Date.now),
        Student(id: 2, name: "Ana", email: "email2@example.com", dni: "23456789", phone: "987654322", birthDate: Date.now)
    ]

    var body: some View {
        ZStack(alignment: .bottomTrailing) {
            VStack(alignment: .leading) {
                Text("Students")
                    .font(AppFont.largeTitle)
                    .foregroundStyle(AppColor.primaryText)

                CustomTextField(
                    placeholder: "Search",
                    text: .constant(""),
                    leftIcon: Image(systemName: "magnifyingglass"),
                    fieldBackgroundColor: AppColor.secondaryBackground
                )

                List(data) { student in
                    StudentTile(student: student) {
                        print("hola amigo")
                    }
                    .listRowInsets(EdgeInsets())
                    .padding(top: 10, bottom: 10)
                }
                .listStyle(.plain)
                .scrollIndicators(.hidden)
            }
            .padding()

            CircularButton {
                print("add")
            }
        }
        .navigationBarHidden(true)


    }
}

#Preview {
    StudentsListView()
}
