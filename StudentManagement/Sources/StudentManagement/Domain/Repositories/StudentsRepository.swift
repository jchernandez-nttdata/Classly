//
//  File.swift
//  StudentManagement
//
//  Created by Juan Carlos Hernandez Castillo on 7/05/25.
//

import Foundation

protocol StudentsRepository {
    func loadStudents() async throws(LoadStudentsError) -> [Student]
    func addStudent(request: AddStudentUseCaseImpl.AddStudentRequest) async throws(ManageStudentError)
    func editStudent(request: EditStudentUseCaseImpl.EditStudentRequest) async throws(ManageStudentError)
}
