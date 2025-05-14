//
//  File.swift
//  Core
//
//  Created by Juan Carlos Hernandez Castillo on 13/05/25.
//

import SwiftUI

@MainActor
public final class ToastManager: ObservableObject {

    public static let shared = ToastManager()
    
    @Published public var message: String? = nil
    @Published public var type: ToastType = .success
    @Published public var isVisible: Bool = false

    private init() {}

    public func showToast(message: String, type: ToastType) {
        self.message = message
        self.type = type
        self.isVisible = true

        DispatchQueue.main.asyncAfter(deadline: .now() + 4) {
            self.isVisible = false
        }
    }
}
