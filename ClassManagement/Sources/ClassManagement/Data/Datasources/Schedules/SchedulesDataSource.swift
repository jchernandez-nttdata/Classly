//
//  SchedulesDataSource.swift
//  ClassManagement
//
//  Created by Juan Carlos Hernandez Castillo on 15/05/25.
//

protocol SchedulesDataSource {
    func loadClassScheduleByLocationId(locationId: Int) async throws -> [ClassSchedule]
    func loadEnrolledStudentsByScheduleId(scheduleId: Int) async throws -> [EnrolledStudent]
    func unenrollStudent(studentId: Int, scheduleId: Int) async throws
    func enrollStudent(params: EnrollStudentImpl.Params) async throws
}
