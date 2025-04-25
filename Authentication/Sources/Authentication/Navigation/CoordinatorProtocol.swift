//
//  File.swift
//  Authentication
//
//  Created by Juan Carlos Hernandez Castillo on 25/04/25.
//

import SwiftUI

@MainActor
public protocol CoordinatorProtocol: AnyObject, ObservableObject {
    associatedtype Route: Hashable
    associatedtype Content: View

    var path: NavigationPath { get set }

    func push(_ route: Route)
    func pop()
    func popToRoot()
    func exitModule()

    @ViewBuilder func build(route: Route) -> Content
    @ViewBuilder func start() -> Content
}

public extension CoordinatorProtocol {
    func push(_ route: Route) {
        path.append(route)
    }

    func pop() {
        guard !path.isEmpty else { return }
        path.removeLast()
    }

    func popToRoot() {
        path.removeLast(path.count)
    }

    func exitModule() {
        print("Exiting module...")
    }
}
