//
//  File.swift
//  ClassesStudent
//
//  Created by Juan Carlos Hernandez Castillo on 31/05/25.
//

import SwiftUI

struct LoadingCameraView: View {
    var body: some View {
        VStack(spacing: 16) {
            ProgressView()
                .scaleEffect(1.2)

            Text("Loading Camera...")
                .font(.body)
                .foregroundColor(.secondary)
        }
    }
}
