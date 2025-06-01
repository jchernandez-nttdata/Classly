//
//  ClassListViewModel.swift
//  ClassesStudent
//
//  Created by Juan Carlos Hernandez Castillo on 29/05/25.
//

import Foundation
import Core

@MainActor
final class ClassListViewModel: ObservableObject {
    // MARK: - Published state
    @Published public var studentClasses: [StudentClass] = []
    @Published public var isLoading = false

    // MARK: - Dependencies
    private let coordinator: (any CoordinatorProtocol)?
    private let toastManager: ToastManager
    private let loadStudentClassesUseCase: LoadStudentClasses?
    private let userSession: UserSessionProtocol?

    // MARK: - Init
    init(
        coordinator: (any CoordinatorProtocol)? = nil,
        toastManager: ToastManager = .shared,
        loadStudentClassesUseCase: LoadStudentClasses? = nil,
        userSession: UserSessionProtocol? = UserSessionManager.shared
    ) {
        self.coordinator = coordinator
        self.toastManager = toastManager
        self.loadStudentClassesUseCase = loadStudentClassesUseCase
        self.userSession = userSession
    }

    // MARK: - Use case calls
    func loadStudentsClasses() {
        guard let loadStudentClassesUseCase else { return }
        Task {
            isLoading = true

            do throws(ClassesStudentListError) {
                let studentId = await userSession?.currentUser?.id
                guard let studentId else { throw .invalidData }
                studentClasses = try await loadStudentClassesUseCase.execute(studentId: studentId)
                guard !studentClasses.isEmpty else { throw .noDataFound }
            } catch {
                switch error {
                case .invalidData:
                    print("no user session")
                    toastManager.showToast(message: "Something went wrong", type: .error)
                case .noDataFound:
                    toastManager.showToast(message: "No classes found", type: .error)
                default:
                    toastManager.showToast(message: "Something went wrong", type: .error)
                }
            }

            isLoading = false
        }
    }

    // MARK: - Private methods


    // MARK: - Coordinator methods
    func toQRScan(studentClass: StudentClass) {
        guard let coordinator = coordinator as? ClassesStudentCoordinator else { return }
        coordinator.push(.QRScan(studentClass))
    }

}
