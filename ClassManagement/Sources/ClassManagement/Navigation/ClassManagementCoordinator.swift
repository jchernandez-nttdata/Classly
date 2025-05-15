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
}

public final class ClassManagementCoordinator: CoordinatorProtocol {
    public typealias Route = ClassManagementRoute
    public typealias Content = AnyView

    @Published public var path = NavigationPath()

    private let dataSource: LocationsDataSource
    private let repository: LocationsRepository
    private let schedulesDataSource: SchedulesDataSource
    private let schedulesRepository: SchedulesRepository
    private let loadLocationsUseCase: LoadLocations
    private let loadClassSchedulesByLocation: LoadClassSchedulesByLocation

    public init() {
        let networkManager = NetworkManager()
        self.dataSource = LocationsDataSourceImpl(networkingManager: networkManager)
        self.repository = LocationsRepositoryImpl(remoteDataSource: dataSource)
        self.loadLocationsUseCase = LoadLocationsImpl(repository: repository)

        self.schedulesDataSource = SchedulesDataSourceImpl(networkingManager: networkManager)
        self.schedulesRepository = SchedulesRepositoryImpl(remoteDataSource: schedulesDataSource)
        self.loadClassSchedulesByLocation = LoadClassSchedulesByLocationImpl(repository: schedulesRepository)
    }

    public func build(route: ClassManagementRoute) -> AnyView {
        switch route {
        case .classList:
            let viewModel = ClassListViewModel(
                coordinator: self,
                loadLocationsUseCase: loadLocationsUseCase,
                loadClassSchedulesByLocation: loadClassSchedulesByLocation
            )
            return AnyView(ClassListView(viewModel: viewModel))
        case .scheduleDetail(let schedule):
            let viewModel = ScheduleDetailViewModel(
                coordinator: self,
                schedule: schedule
            )
            return AnyView(ScheduleDetailView(viewModel: viewModel))
        }
    }

    @ViewBuilder public func start() -> AnyView {
        AnyView(ClassManagementRootView(coordinator: self))
    }

}
