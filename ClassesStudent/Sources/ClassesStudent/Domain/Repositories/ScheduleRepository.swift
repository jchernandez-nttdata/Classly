//
//  ScheduleRepository.swift
//  ClassesStudent
//
//  Created by Juan Carlos Hernandez Castillo on 29/05/25.
//

protocol ScheduleRepository: Sendable {
    func loadStudentClasses(studentId: Int) async throws(ClassesStudentListError) -> [StudentClass]
    func addAttendance(userScheduleId: Int, locationId: Int) async throws(AddAssistanceError)
}
