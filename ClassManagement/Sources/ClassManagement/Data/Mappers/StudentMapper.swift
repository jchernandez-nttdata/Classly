//
//  StudentMapper.swift
//  ClassManagement
//
//  Created by Juan Carlos Hernandez Castillo on 16/05/25.
//

import Core

class StudentMapper {
    private static func mapToStudent(response: LoadStudentsQueryResponse) -> Student {
        return Student(
            id: response.id,
            name: response.name,
            email: response.email,
            dni: response.dni,
            phone: response.phone,
            birthdate: response.birthdate.toDate()
        )
    }

    static func mapToStudents(responses: [LoadStudentsQueryResponse]) -> [Student] {
        return responses.map(mapToStudent)
    }
}
