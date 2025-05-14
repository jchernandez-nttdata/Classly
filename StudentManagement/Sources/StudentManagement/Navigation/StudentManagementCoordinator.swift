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

    private let dataSource: StudentsDataSource
    private let repository: StudentsRepository
    private let loadStudentsUseCase: LoadStudentsUseCase
    private let addStudentUseCase: AddStudentUseCase
    private let editStudentUseCase: EditStudentUseCase

    public init() {
        let networkManager = NetworkManager()
        self.dataSource = StudentsDataSourceImpl(networkingManager: networkManager)
        self.repository = StudentsRepositoryImpl(remoteDataSource: dataSource)
        self.loadStudentsUseCase = LoadStudentsUseCaseImpl(repository: repository)
        self.addStudentUseCase = AddStudentUseCaseImpl(repository: repository)
        self.editStudentUseCase = EditStudentUseCaseImpl(repository: repository)
    }

    public func build(route: StudentManagementRoute) -> AnyView {
        switch route {
        case .studentsList:
            let viewModel = StudentsListViewModel(
                coordinator: self,
                loadStudentsUseCase: loadStudentsUseCase
            )
            return AnyView(StudentsListView(viewModel: viewModel))
        case .manageStudent(let student):
            let viewModel = ManageStudentViewModel(
                coordinator: self,
                addStudent: addStudentUseCase,
                editStudent: editStudentUseCase,
                existingStudent: student
            )
            return AnyView(ManageStudentView(viewModel: viewModel))
        }
    }

    @ViewBuilder public func start() -> AnyView {
        AnyView(StudentManagementRootView(coordinator: self))
    }

}
