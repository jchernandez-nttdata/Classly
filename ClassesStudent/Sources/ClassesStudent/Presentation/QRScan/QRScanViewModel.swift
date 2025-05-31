//
//  QRScanViewModel.swift
//  ClassesStudent
//
//  Created by Juan Carlos Hernandez Castillo on 31/05/25.
//

import Foundation
import Core

@MainActor
final class QRScanViewModel: ObservableObject {
    // MARK: - Published state
    @Published public var isLoading = false

    // MARK: - Dependencies
    private let coordinator: (any CoordinatorProtocol)?
    private let toastManager: ToastManager
    private let userSession: UserSessionProtocol?

    // MARK: - Init
    init(
        coordinator: (any CoordinatorProtocol)? = nil,
        toastManager: ToastManager = .shared,
        userSession: UserSessionProtocol? = UserSessionManager.shared
    ) {
        self.coordinator = coordinator
        self.toastManager = toastManager
        self.userSession = userSession
    }

    // MARK: - Public methods
    func handleScannedCode(_ code: String) async {
        print("Scanned QR Code: \(code)")
    }

    // MARK: - Private methods


    // MARK: - Coordinator methods
    func goBack() {
        coordinator?.pop()
    }

}
