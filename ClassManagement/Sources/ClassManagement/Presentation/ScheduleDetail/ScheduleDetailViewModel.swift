//
//  ScheduleDetailViewModel.swift
//  ClassManagement
//
//  Created by Juan Carlos Hernandez Castillo on 15/05/25.
//

import Foundation
import Core

@MainActor
final class ScheduleDetailViewModel: ObservableObject {
    // MARK: - Published state
    @Published public var isLoading = false
    @Published public var enrolledStudents: [EnrolledStudent] = []

    // MARK: - Dependencies
    var schedule: ClassSchedule
    private let coordinator: (any CoordinatorProtocol)?
    private let loadEnrolledStudentsBySchedule: LoadEnrolledStudentsBySchedule?
    private let toastManager: ToastManager

    // MARK: - Init
    init(
        coordinator: (any CoordinatorProtocol)? = nil,
        schedule: ClassSchedule,
        loadEnrolledStudentsBySchedule: LoadEnrolledStudentsBySchedule? = nil,
        toastManager: ToastManager = .shared
    ) {
        self.coordinator = coordinator
        self.schedule = schedule
        self.loadEnrolledStudentsBySchedule = loadEnrolledStudentsBySchedule
        self.toastManager = toastManager
    }

    func goBack() {
        coordinator?.pop()
    }

    func loadEnrolledStudents() {
        guard let loadEnrolledStudentsBySchedule else { return }

        Task {
            isLoading = true

            // simulates loading
            try await Task.sleep(nanoseconds: 1_500_000_000)

            do {
                enrolledStudents = try await loadEnrolledStudentsBySchedule.execute(scheduleId: schedule.id)
                guard !enrolledStudents.isEmpty else { throw ClassManagementListError.noDataFound }

            } catch let error as ClassManagementListError {
                switch error {
                case .noDataFound:
                    toastManager.showToast(message: "No enrolled students found", type: .error)
                default:
                    toastManager.showToast(message: "An unexpected error occurred", type: .error)
                }
            }

            isLoading = false
        }
    }
}
