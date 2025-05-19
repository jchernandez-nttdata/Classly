//
//  ClassManagementCoordinator.swift
//  ClassManagement
//
//  Created by Juan Carlos Hernandez Castillo on 14/05/25.
//

import SwiftUI
import ClasslyNetworking
import Core

public enum ClassManagementRoute: Hashable {
    case classList
    case scheduleDetail(ClassSchedule)
    case enrollStudent(ClassSchedule)
    case assistances(ClassSchedule)
}

public final class ClassManagementCoordinator: CoordinatorProtocol {
    public typealias Route = ClassManagementRoute
    public typealias Content = AnyView

    @Published public var path = NavigationPath()

    private let di: ClassManagementDIContainer

    public init(di: ClassManagementDIContainer) {
        self.di = di
    }

    public func build(route: ClassManagementRoute) -> AnyView {
        switch route {
        case .classList:
            let viewModel = ClassListViewModel(
                coordinator: self,
                loadLocationsUseCase: di.loadLocations,
                loadClassSchedulesByLocation: di.loadClassSchedulesByLocation
            )
            return AnyView(ClassListView(viewModel: viewModel))
        case .scheduleDetail(let schedule):
            let viewModel = ScheduleDetailViewModel(
                coordinator: self,
                schedule: schedule,
                loadEnrolledStudentsBySchedule: di.loadEnrolledStudentsBySchedule,
                unenrollStudent: di.unenrollStudent
            )
            return AnyView(ScheduleDetailView(viewModel: viewModel))
        case .enrollStudent(let schedule):
            let viewModel = EnrollStudentViewModel(
                coordinator: self,
                schedule: schedule,
                loadStudentsQuery: di.loadStudentsQuery,
                enrollStudent: di.enrollStudent
            )
            return AnyView(EnrollStudentView(viewModel: viewModel))
        case .assistances(let schedule):
            let viewModel = AssistancesViewModel(
                coordinator: self,
                schedule: schedule,
                loadAttendancesDatesUseCase: di.loadAttendancesDates
            )
            return AnyView(AssistancesView(viewModel: viewModel))
        }
    }

    @ViewBuilder public func start() -> AnyView {
        AnyView(ClassManagementRootView(coordinator: self))
    }
}
