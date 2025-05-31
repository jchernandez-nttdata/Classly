//
//  QRScanView.swift
//  ClassesStudent
//
//  Created by Juan Carlos Hernandez Castillo on 31/05/25.
//

import SwiftUI
import UIComponents
import Assets

struct QRScanView: View {
    @StateObject private var viewModel: QRScanViewModel
    @StateObject private var cameraManager = CameraManager()

    public init(viewModel: QRScanViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }

    var body: some View {
        VStack(spacing: 0) {
            CustomAppBar(title: "Scan QR code", backAction: viewModel.goBack)

            ZStack {
                Color.black

                if cameraManager.permissionGranted {
                    CameraPreviewViewRepresentable(cameraManager: cameraManager)
                        .onReceive(cameraManager.$scannedCode) { code in
                            if let code = code {
                                Task { @MainActor in
                                    await viewModel.handleScannedCode(code)
                                }
                            }
                        }

                    QRScannerOverlay()

                } else if cameraManager.permissionDenied {
                    PermissionDeniedView()
                } else {
                    LoadingCameraView()
                }
            }
            .task {
                await cameraManager.requestCameraPermission()
            }
            .onDisappear {
                Task {
                    await cameraManager.stopSession()
                }
            }

            Spacer()

            Image(uiImage: AssetImage.logoClassly)
                .resizable()
                .scaledToFit()
                .frame(height: 40)
        }
        .navigationBarHidden(true)
        .padding()
    }
}
