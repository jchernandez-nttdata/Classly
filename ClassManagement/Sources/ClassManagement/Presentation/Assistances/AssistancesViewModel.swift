//
//  AssistancesViewModel.swift
//  ClassManagement
//
//  Created by Juan Carlos Hernandez Castillo on 16/05/25.
//

import Foundation
import Core

@MainActor
final class AssistancesViewModel: ObservableObject {
    // MARK: - Published state
    @Published public var isLoading = false

    // MARK: - Dependencies
    var schedule: ClassSchedule
    private let coordinator: (any CoordinatorProtocol)?
    private let toastManager: ToastManager

    // MARK: - Init
    init(
        coordinator: (any CoordinatorProtocol)? = nil,
        schedule: ClassSchedule,
        toastManager: ToastManager = .shared
    ) {
        self.coordinator = coordinator
        self.schedule = schedule
        self.toastManager = toastManager
    }

    // MARK: - Coordinator methods

    func goBack() {
        coordinator?.pop()
    }
}
