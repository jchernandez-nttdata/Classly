//
//  ScheduleDataSource.swift
//  ClassesStudent
//
//  Created by Juan Carlos Hernandez Castillo on 29/05/25.
//

protocol ScheduleDataSource {
    func loadStudentClasses(studentId: Int) async throws -> [StudentClass]
}
