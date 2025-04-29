//
//  LoginViewModel.swift
//  Authentication
//
//  Created by Juan Carlos Hernandez Castillo on 25/04/25.
//

import Foundation

@MainActor
public final class LoginViewModel: ObservableObject {
    @Published public var email = ""
    @Published public var password = ""

    private let coordinator: (any CoordinatorProtocol)?

    public init(coordinator: (any CoordinatorProtocol)? = nil) {
        self.coordinator = coordinator
    }

    public func login() {
        coordinator?.exitModule()
    }
}

extension LoginViewModel {
    static var preview: LoginViewModel {
        LoginViewModel(coordinator: nil)
    }
}
