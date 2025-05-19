//
//  AttendancesRepository.swift
//  ClassManagement
//
//  Created by Juan Carlos Hernandez Castillo on 19/05/25.
//

import Foundation

protocol AttendancesRepository {
    func loadAttendancesDates(scheduleId: Int) async throws(ClassManagementListError) -> [String]
    func loadStudentAttendances(scheduleId: Int, date: String) async throws(ClassManagementListError) -> [StudentAttendance]
}
