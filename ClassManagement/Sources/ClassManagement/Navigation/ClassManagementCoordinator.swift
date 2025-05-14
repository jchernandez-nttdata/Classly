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

    public init() {
    }

    public func build(route: ClassManagementRoute) -> AnyView {
        switch route {
        case .classList:
            return AnyView(ClassListView())
        }
    }

    @ViewBuilder public func start() -> AnyView {
        AnyView(ClassManagementRootView(coordinator: self))
    }

}
