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
}

public final class ClassManagementCoordinator: CoordinatorProtocol {
    public typealias Route = ClassManagementRoute
    public typealias Content = AnyView

    @Published public var path = NavigationPath()

    private let dataSource: LocationsDataSource
    private let repository: LocationsRepository
    private let loadLocationsUseCase: LoadLocationsUseCase

    public init() {
        let networkManager = NetworkManager()
        self.dataSource = LocationsDataSourceImpl(networkingManager: networkManager)
        self.repository = LocationsRepositoryImpl(remoteDataSource: dataSource)
        self.loadLocationsUseCase = LoadLocationsUseCaseImpl(repository: repository)
    }

    public func build(route: ClassManagementRoute) -> AnyView {
        switch route {
        case .classList:
            let viewModel = ClassListViewModel(
                coordinator: self,
                loadLocationsUseCase: loadLocationsUseCase
            )
            return AnyView(ClassListView(viewModel: viewModel))
        }
    }

    @ViewBuilder public func start() -> AnyView {
        AnyView(ClassManagementRootView(coordinator: self))
    }

}
