//
//  LoadStudentClasses.swift
//  ClassesStudent
//
//  Created by Juan Carlos Hernandez Castillo on 29/05/25.
//

protocol LoadStudentClasses {
    func execute(studentId: Int) async throws(ClassesStudentListError) -> [StudentClass]
}

final class LoadStudentClassesImpl: LoadStudentClasses {
    private let repository: ScheduleRepository

    init(repository: ScheduleRepository) {
        self.repository = repository
    }

    func execute(studentId: Int) async throws(ClassesStudentListError) -> [StudentClass] {
        return try await repository.loadStudentClasses(studentId: studentId)
    }
}
