//
//  File.swift
//  ClassesStudent
//
//  Created by Juan Carlos Hernandez Castillo on 28/05/25.
//

import SwiftUI
import ClasslyNetworking
import Core

public enum ClassesStudentRoute: Hashable {
    case classList
    case QRScan
}

public final class ClassesStudentCoordinator: CoordinatorProtocol {
    public typealias Route = ClassesStudentRoute
    public typealias Content = AnyView

    @Published public var path = NavigationPath()

    private let di: ClassesStudentDIContainer

    public init(di: ClassesStudentDIContainer) {
        self.di = di
    }

    public func build(route: ClassesStudentRoute) -> AnyView {
        switch route {
        case .classList:
            let viewModel = ClassListViewModel(
                coordinator: self,
                loadStudentClassesUseCase: di.loadStudentClasses
            )
            return AnyView(ClassListView(viewModel: viewModel))
        case .QRScan:
            let viewModel = QRScanViewModel(coordinator: self)
            return AnyView(QRScanView(viewModel: viewModel))
        }
    }

    @ViewBuilder public func start() -> AnyView {
        AnyView(ClassesStudentRootView(coordinator: self))
    }
}
