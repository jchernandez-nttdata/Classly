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

    public init() {}

    public func build(route: StudentManagementRoute) -> AnyView {
        switch route {
        case .studentsList:
            let datasource = StudentsDataSourceImpl(networkingManager: NetworkManager())
            let repository = StudentsRepositoryImpl(remoteDataSource: datasource)
            let useCase = LoadStudentsUseCaseImpl(repository: repository)
            let viewModel = StudentsListViewModel(coordinator: self, loadStudentsUseCase: useCase)
            return AnyView(StudentsListView(viewModel: viewModel))
        case .manageStudent(let student):
            let viewModel = ManageStudentViewModel(coordinator: self, existingStudent: student)
            return AnyView(ManageStudentView(viewModel: viewModel))
        }
    }

    @ViewBuilder public func start() -> AnyView {
        AnyView(StudentManagementRootView(coordinator: self))
    }

}
