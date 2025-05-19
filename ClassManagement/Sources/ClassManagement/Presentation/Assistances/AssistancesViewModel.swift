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
    @Published public var showAttendancesSheet: Bool = false
    @Published public var isAttendancesLoading: Bool = false
    @Published public var studentAttendances: [StudentAttendance] = []
    @Published public var selectedDate: String = ""

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

    func loadStudentAttendances(for date: Date) {
        studentAttendances = []
        selectedDate = DateUtils.formatDate(date)

        showAttendancesSheet = true
        isAttendancesLoading = true

        Task {
            // simulates loading
            try await Task.sleep(nanoseconds: 2_500_000_000)
            studentAttendances = [
                StudentAttendance(studentId: 1, name: "Juan Pérez", registrationDate: .now),
                StudentAttendance(studentId: 2, name: "wefwef wefwefw fwefwefwef", registrationDate: .now),
                StudentAttendance(studentId: 3, name: "AAAAAA", registrationDate: .now),
                StudentAttendance(studentId: 4, name: "efwefw", registrationDate: .now),
                StudentAttendance(studentId: 5, name: "wefwefw wefwef", registrationDate: .now)
            ]

            isAttendancesLoading = false
        }
    }

    // MARK: - Coordinator methods

    func goBack() {
        coordinator?.pop()
    }
}
