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
}

public final class StudentManagementCoordinator: CoordinatorProtocol {
    public typealias Route = StudentManagementRoute
    public typealias Content = AnyView

    @Published public var path = NavigationPath()

    public init() {
        // initial route
        path.append(StudentManagementRoute.studentsList)
    }

    public func build(route: StudentManagementRoute) -> AnyView {
        switch route {
        case .studentsList:
            return AnyView(Text("studentsList"))
        }
    }

    @ViewBuilder public func start() -> AnyView {
        AnyView(StudentManagementRootView(coordinator: self))
    }

}
