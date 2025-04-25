//
//  AuthenticationCoordinator.swift
//  Authentication
//
//  Created by Juan Carlos Hernandez Castillo on 25/04/25.
//

import SwiftUI

public enum AuthRoute: Hashable {
    case login
    case forgotPassword
}

public final class AuthenticationCoordinator: CoordinatorProtocol {
    public typealias Route = AuthRoute
    public typealias Content = AnyView

    @Published public var path = NavigationPath()

    private let onExit: () -> Void

    public init(
        onExit: @escaping () -> Void
    ) {
        self.onExit = onExit
        // initial route
        path.append(AuthRoute.login)
    }

    public func build(route: AuthRoute) -> AnyView {
        switch route {
        case .login:
            let viewModel = LoginViewModel(coordinator: self)
            return AnyView(LoginView(viewModel: viewModel))
        case .forgotPassword:
            return AnyView(Text("Forgot password"))
        }
    }

    @ViewBuilder public func start() -> AnyView {
        AnyView(AuthenticationRootView(coordinator: self))
    }

    public func exitModule() {
        onExit()
    }
}
