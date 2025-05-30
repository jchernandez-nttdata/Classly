//
//  ScheduleRepository.swift
//  ClassesStudent
//
//  Created by Juan Carlos Hernandez Castillo on 29/05/25.
//

protocol ScheduleRepository {
    func loadStudentClasses(studentId: Int) async throws(ClassesStudentListError) -> [StudentClass]
}
