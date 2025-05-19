//
//  ScheduleRepository.swift
//  ClassManagement
//
//  Created by Juan Carlos Hernandez Castillo on 15/05/25.
//

import Foundation

protocol SchedulesRepository {
    func loadClassScheduleByLocationId(locationId: Int) async throws(ClassManagementListError) -> [ClassSchedule]
    func loadEnrolledStudentsByScheduleId(scheduleId: Int) async throws(ClassManagementListError) -> [EnrolledStudent]
    func unenrollStudent(studentId: Int, scheduleId: Int) async throws(UnenrollStudentError)
    func enrollStudent(params: EnrollStudentImpl.Params) async throws(EnrollStudentError)
}
