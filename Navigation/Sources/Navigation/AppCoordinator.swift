//
//  AppCoordinator.swift
//  Navigation
//
//  Created by Juan Carlos Hernandez Castillo on 23/04/25.
//

import SwiftUI
import Authentication
import Core
import StudentManagement
import ClassManagement
import PaymentsManagement
import ClassesStudent

@MainActor
public final class AppCoordinator: ObservableObject {
    @Published public var state: NavigationState = .authentication
    public var authCoordinator: AuthenticationCoordinator?
    public var studentManagementCoordinator: StudentManagementCoordinator?
    public var classManagementCoordinator: ClassManagementCoordinator?
    public var paymentsManagementCoordinator: PaymentsManagementCoordinator?
    public var classesStudentCoordinator: ClassesStudentCoordinator?

    public init() {
        setupAuthenticationCoordinator()
        login(as: .student)
    }

    public func login(as role: UserRole) {
        switch role {
        case .admin:
            let studentDI = StudentManagementDIContainer()
            studentManagementCoordinator = StudentManagementCoordinator(di: studentDI)
            let classDI = ClassManagementDIContainer()
            classManagementCoordinator = ClassManagementCoordinator(di: classDI)
            let paymentsDI = PaymentsManagementDIContainer()
            paymentsManagementCoordinator = PaymentsManagementCoordinator(di: paymentsDI)
            state = .admin
        case .student:
            classesStudentCoordinator = ClassesStudentCoordinator()
            state = .student
        }
    }

    public func logout() {
        if state == .student {
            classesStudentCoordinator = nil
        } else if state == .admin {
            studentManagementCoordinator = nil
            classManagementCoordinator = nil
            paymentsManagementCoordinator = nil
        }
        state = .authentication
    }

    private func setupAuthenticationCoordinator() {
        authCoordinator = AuthenticationCoordinator(onExit: { [weak self] role in
            self?.login(as: role)
        })
    }
}
