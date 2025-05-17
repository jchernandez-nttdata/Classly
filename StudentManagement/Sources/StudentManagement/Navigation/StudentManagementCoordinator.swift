//
//  StudentManagementCoordinator.swift
//  StudentManagement
//
//  Created by Juan Carlos Hernandez Castillo on 6/05/25.
//

import SwiftUI
import ClasslyNetworking
import Core

public enum StudentManagementRoute: Hashable {
    case studentsList
    case manageStudent(Student?)
}

public final class StudentManagementCoordinator: CoordinatorProtocol {
    public typealias Route = StudentManagementRoute
    public typealias Content = AnyView

    @Published public var path = NavigationPath()

    private let di: StudentManagementDIContainer

    public init(di: StudentManagementDIContainer) {
        self.di = di
    }

    public func build(route: StudentManagementRoute) -> AnyView {
        switch route {
        case .studentsList:
            let viewModel = StudentsListViewModel(
                coordinator: self,
                loadStudentsUseCase: di.loadStudentsUseCase
            )
            return AnyView(StudentsListView(viewModel: viewModel))
        case .manageStudent(let student):
            let viewModel = ManageStudentViewModel(
                coordinator: self,
                addStudent: di.addStudentUseCase,
                editStudent: di.editStudentUseCase,
                existingStudent: student
            )
            return AnyView(ManageStudentView(viewModel: viewModel))
        }
    }

    @ViewBuilder public func start() -> AnyView {
        AnyView(StudentManagementRootView(coordinator: self))
    }
}
