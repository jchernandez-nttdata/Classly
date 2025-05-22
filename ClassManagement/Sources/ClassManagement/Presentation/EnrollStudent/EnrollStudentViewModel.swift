//
//  EnrollStudentViewModel.swift
//  ClassManagement
//
//  Created by Juan Carlos Hernandez Castillo on 13/05/25.
//

import Foundation
import Core

@MainActor
final class EnrollStudentViewModel: ObservableObject {
    @Published public var isLoading = false
    @Published var searchResults: [Student] = []
    @Published var selectedStudent: Student?
    @Published var amountString: String = ""
    @Published var paidClassesString: String = ""

    var schedule: ClassSchedule

    private let coordinator: (any CoordinatorProtocol)?
    private let toastManager: ToastManager
    private let loadStudentsQuery: LoadStudentsQuery?
    private let enrollStudentUseCase: EnrollStudent?

    init(
        coordinator: (any CoordinatorProtocol)? = nil,
        schedule: ClassSchedule,
        toastManager: ToastManager = .shared,
        loadStudentsQuery: LoadStudentsQuery? = nil,
        enrollStudent: EnrollStudent? = nil
    ) {
        self.coordinator = coordinator
        self.schedule = schedule
        self.toastManager = toastManager
        self.loadStudentsQuery = loadStudentsQuery
        self.enrollStudentUseCase = enrollStudent
    }

    func goBack() {
        coordinator?.pop()
    }

    func searchStudentNames(query: String) async -> [Student] {
        guard let safeUseCase = loadStudentsQuery else { return [] }
        do {
            searchResults = try await safeUseCase.execute(query: query)
            return searchResults
        } catch {
            return []
        }
    }

    func enrollStudent() {
        guard let enrollStudentUseCase else { return }

        Task {
            isLoading = true

            do throws(EnrollStudentError) {
                guard let studentId = searchResults.filter({ $0.id == selectedStudent?.id }).first?.id else {
                    print("Student not found")
                    throw .parseError
                }
                guard let amount = Double(amountString) else {
                    print("Cannot convert amount")
                    throw .parseError
                }
                guard let paidClasses = Int(paidClassesString) else {
                    print("cannot convert paid classes")
                    throw .parseError
                }
                let params = EnrollStudentImpl.Params(
                    studentId: studentId,
                    scheduleId: schedule.id,
                    amount: amount,
                    paidClasses: paidClasses
                )
                try await enrollStudentUseCase.execute(params: params)
                toastManager.showToast(message: "Successfully enrolled", type: .success)
                goBack()
            } catch {
                switch error {
                case .notFound:
                    toastManager.showToast(message: "Student or Schedule not found", type: .error)
                case .parseError:
                    toastManager.showToast(message: "There was an error parsing the data", type: .error)
                default:
                    toastManager.showToast(message: "Something went wrong", type: .error)
                }
            }

            isLoading = false
        }
    }
}
