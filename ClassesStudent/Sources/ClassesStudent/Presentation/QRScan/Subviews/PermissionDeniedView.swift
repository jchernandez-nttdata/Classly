//
//  File.swift
//  ClassesStudent
//
//  Created by Juan Carlos Hernandez Castillo on 31/05/25.
//

import SwiftUI
import UIComponents

struct PermissionDeniedView: View {
    var body: some View {
        VStack(spacing: 24) {
            Image(systemName: "camera.fill")
                .font(.system(size: 60))
                .foregroundColor(.gray)

            VStack(spacing: 12) {
                Text("Camera Access Required")
                    .font(.title2)
                    .fontWeight(.semibold)

                Text("Please enable camera access in Settings to scan QR codes")
                    .font(.body)
                    .multilineTextAlignment(.center)
                    .foregroundColor(.secondary)
            }

            CustomButton(title: "Open settings") {
                if let settingsURL = URL(string: UIApplication.openSettingsURLString) {
                    UIApplication.shared.open(settingsURL)
                }
            }
        }
        .padding(32)
    }
}
