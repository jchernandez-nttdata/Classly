//
//  StudentsDataSource.swift
//  StudentManagement
//
//  Created by Juan Carlos Hernandez Castillo on 7/05/25.
//

import Core

protocol StudentsDataSource {
    func loadStudents() async throws -> [Student]
    func addStudent(request: AddStudentImpl.AddStudentRequest) async throws
    func editStudent(request: EditStudentImpl.EditStudentRequest) async throws
}
