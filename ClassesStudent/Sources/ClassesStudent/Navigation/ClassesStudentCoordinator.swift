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
}

public final class ClassesStudentCoordinator: CoordinatorProtocol {
    public typealias Route = ClassesStudentRoute
    public typealias Content = AnyView

    @Published public var path = NavigationPath()

//    private let di: PaymentsManagementDIContainer

//    public init(di: PaymentsManagementDIContainer) {
    public init() {
//        self.di = di
    }

    public func build(route: ClassesStudentRoute) -> AnyView {
        switch route {
        case .classList:
//            let viewModel = PaymentsListViewModel(
//                coordinator: self,
//                loadPaymentsUseCase: di.loadPayments
//            )
            return AnyView(ClassListView())
        }
    }

    @ViewBuilder public func start() -> AnyView {
        AnyView(ClassesStudentRootView(coordinator: self))
    }
}
