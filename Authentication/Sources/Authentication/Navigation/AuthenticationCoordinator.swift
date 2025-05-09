//
//  AuthenticationCoordinator.swift
//  Authentication
//
//  Created by Juan Carlos Hernandez Castillo on 25/04/25.
//

import SwiftUI
import ClasslyNetworking
import Core

public enum AuthRoute: Hashable {
    case login
}

public final class AuthenticationCoordinator: CoordinatorProtocol {
    public typealias Route = AuthRoute
    public typealias Content = AnyView

    @Published public var path = NavigationPath()

    private let onExit: (UserRole) -> Void

    public init(
        onExit: @escaping (UserRole) -> Void
    ) {
        self.onExit = onExit
        // initial route
        path.append(AuthRoute.login)
    }

    public func build(route: AuthRoute) -> AnyView {
        switch route {
        case .login:
            let datasource = AuthRemoteDataSourceImpl(networkingManager: NetworkManager())
            let repository = AuthRepositoryImpl(remoteDataSource: datasource)
            let useCase = LoginUseCaseImpl(repository: repository)
            let sessionManager = UserSessionManager.shared
            let viewModel = LoginViewModel(
                coordinator: self,
                loginUseCase: useCase,
                userSessionManager: sessionManager
            )

            return AnyView(LoginView(viewModel: viewModel))
        }
    }

    @ViewBuilder public func start() -> AnyView {
        AnyView(AuthenticationRootView(coordinator: self))
    }

    public func exitModule(role: UserRole) {
        onExit(role)
    }
}
