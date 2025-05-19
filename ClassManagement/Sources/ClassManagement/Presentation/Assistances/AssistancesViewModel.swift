//
//  AssistancesViewModel.swift
//  ClassManagement
//
//  Created by Juan Carlos Hernandez Castillo on 16/05/25.
//

import Foundation
import Core

@MainActor
final class AssistancesViewModel: ObservableObject {
    // MARK: - Published state
    @Published public var isLoading = false
    @Published public var attendancesDates: [String] = []

    // MARK: - Dependencies
    var schedule: ClassSchedule
    private let coordinator: (any CoordinatorProtocol)?
    private let toastManager: ToastManager
    private let loadAttendancesDatesUseCase: LoadAttendancesDates?

    // MARK: - Init
    init(
        coordinator: (any CoordinatorProtocol)? = nil,
        schedule: ClassSchedule,
        toastManager: ToastManager = .shared,
        loadAttendancesDatesUseCase: LoadAttendancesDates? = nil
    ) {
        self.coordinator = coordinator
        self.schedule = schedule
        self.toastManager = toastManager
        self.loadAttendancesDatesUseCase = loadAttendancesDatesUseCase
    }

    func loadAttendancesDates() {
        guard let loadAttendancesDatesUseCase else { return }
        Task {
            isLoading = true

            do throws (ClassManagementListError) {
                attendancesDates = try await loadAttendancesDatesUseCase.execute(scheduleId: schedule.id)
                if attendancesDates.isEmpty {
                    throw .noDataFound
                }
            } catch {
                switch error {
                case .noDataFound:
                    toastManager.showToast(message: "No attendances found", type: .error)
                default:
                    toastManager.showToast(message: "Something went wrong", type: .error)
                }
            }

            isLoading = false
        }
    }

    // MARK: - Coordinator methods

    func goBack() {
        coordinator?.pop()
    }
}
