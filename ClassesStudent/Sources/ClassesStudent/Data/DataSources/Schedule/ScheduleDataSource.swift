//
//  ScheduleDataSource.swift
//  ClassesStudent
//
//  Created by Juan Carlos Hernandez Castillo on 29/05/25.
//

protocol ScheduleDataSource: Sendable {
    func loadStudentClasses(studentId: Int) async throws -> [StudentClass]
    func addAttendance(userScheduleId: Int, locationId: Int) async throws
}
