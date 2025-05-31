//
//  QRScannerOverlay.swift
//  ClassesStudent
//
//  Created by Juan Carlos Hernandez Castillo on 31/05/25.
//

import SwiftUI

struct QRScannerOverlay: View {
    var body: some View {
        ZStack {
            Color.black.opacity(0.5)

            RoundedRectangle(cornerRadius: 12)
                .strokeBorder(Color.white, lineWidth: 2)
                .frame(width: 250, height: 250)
                .background(Color.clear)

            VStack {
                Spacer()

                Text("Scan the QR of your class")
                    .foregroundColor(.white)
                    .font(.system(size: 16, weight: .medium))
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 32)
                    .padding(.bottom, 100)
            }
        }
    }
}
