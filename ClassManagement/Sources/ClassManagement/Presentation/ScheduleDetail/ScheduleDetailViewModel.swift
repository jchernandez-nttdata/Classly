//
//  ScheduleDetailViewModel.swift
//  ClassManagement
//
//  Created by Juan Carlos Hernandez Castillo on 15/05/25.
//

import Foundation
import Core

@MainActor
final class ScheduleDetailViewModel: ObservableObject {
    var schedule: ClassSchedule

    private let coordinator: (any CoordinatorProtocol)?
    private let toastManager: ToastManager

    init(
        coordinator: (any CoordinatorProtocol)? = nil,
        schedule: ClassSchedule,
        toastManager: ToastManager = .shared
    ) {
        self.coordinator = coordinator
        self.schedule = schedule
        self.toastManager = toastManager
    }

    func goBack() {
        coordinator?.pop()
    }
}
