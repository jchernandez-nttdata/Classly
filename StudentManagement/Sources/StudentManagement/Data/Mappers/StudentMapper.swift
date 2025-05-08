//
//  File.swift
//  StudentManagement
//
//  Created by Juan Carlos Hernandez Castillo on 7/05/25.
//

import Core

class StudentMapper {
    private static func mapToStudent(response: LoadStudentsResponse) -> Student {
        return Student(
            id: response.id,
            name: response.name,
            email: response.email,
            dni: response.dni,
            phone: response.phone,
            birthDate: response.birthdate.toDate()
        )
    }

    static func mapToStudents(responses: [LoadStudentsResponse]) -> [Student] {
        return responses.map(mapToStudent)
    }
}
