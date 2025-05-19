//
//  AttendancesDataSource.swift
//  ClassManagement
//
//  Created by Juan Carlos Hernandez Castillo on 19/05/25.
//

protocol AttendancesDataSource {
    func loadAttendancesDates(scheduleId: Int) async throws -> [String]
}
