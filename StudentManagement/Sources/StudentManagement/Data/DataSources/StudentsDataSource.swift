//
//  StudentsDataSource.swift
//  StudentManagement
//
//  Created by Juan Carlos Hernandez Castillo on 7/05/25.
//

protocol StudentsDataSource {
    func loadStudents() async throws -> [Student]
    func addStudent(request: AddStudentUseCaseImpl.AddStudentRequest) async throws
    func editStudent(request: EditStudentUseCaseImpl.EditStudentRequest) async throws
}
