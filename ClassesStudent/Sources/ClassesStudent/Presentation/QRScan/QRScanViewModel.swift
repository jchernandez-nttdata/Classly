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
    private var isProcessingQR = false

    // MARK: - Dependencies
    private let userSchedule: StudentClass
    private let coordinator: (any CoordinatorProtocol)?
    private let toastManager: ToastManager
    private let addAttendanceUseCase: AddAttendance?

    // MARK: - Init
    init(
        userSchedule: StudentClass,
        coordinator: (any CoordinatorProtocol)? = nil,
        toastManager: ToastManager = .shared,
        addAttendanceUseCase: AddAttendance? = nil
    ) {
        self.userSchedule = userSchedule
        self.coordinator = coordinator
        self.toastManager = toastManager
        self.addAttendanceUseCase = addAttendanceUseCase
    }

    // MARK: - Public methods
    func handleScannedCode(_ code: String) async {
         print("Scanned QR Code: \(code)")

         guard !isProcessingQR else {
             print("Already processing QR code, ignoring...")
             return
         }

         guard let intValue = Int(code) else {
             toastManager.showToast(message: "Invalid QR Code", type: .error)
             goBack()
             return
         }

         isProcessingQR = true

         await addAttendance(locationId: intValue)

         isProcessingQR = false
     }

    // MARK: - Private methods

    private func addAttendance(locationId: Int) async {
        guard let addAttendanceUseCase else { return }

        isLoading = true
        
        do throws(AddAssistanceError) {
            try await addAttendanceUseCase.execute(
                userScheduleId: userSchedule.id,
                QRLocationId: locationId
            )
        } catch {
            switch error {
            case .noRemainingClasses:
                toastManager.showToast(message: "No remaining classes", type: .error)
            case .locationMismatch:
                toastManager.showToast(message: "QR Code does not match class", type: .error)
            case .classNotToday:
                toastManager.showToast(message: "Class is not today. Contact administrator to register attendance", type: .error)
            case .alreadyRegistered:
                toastManager.showToast(message: "Attendance already registered", type: .error)
            default:
                toastManager.showToast(message: "Something went wrong", type: .error)
            }
        }

        goBack()
        isLoading = false
    }

    // MARK: - Coordinator methods
    func goBack() {
        coordinator?.pop()
    }

}
