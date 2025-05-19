//
//  EnrollStudent.swift
//  ClassManagement
//
//  Created by Juan Carlos Hernandez Castillo on 19/05/25.
//

protocol EnrollStudent {
    func execute(params: EnrollStudentImpl.Params) async throws(EnrollStudentError)
}

final class EnrollStudentImpl: EnrollStudent {
    private let repository: SchedulesRepository

    struct Params {
        let studentId: Int
        let scheduleId: Int
        let amount: Double
        let paidClasses: Int
    }

    init(repository: SchedulesRepository) {
        self.repository = repository
    }

    func execute(params: EnrollStudentImpl.Params) async throws(EnrollStudentError) {
        return try await repository.enrollStudent(params: params)
    }
}
