//
//  CameraView.swift
//  ClassesStudent
//
//  Created by Juan Carlos Hernandez Castillo on 31/05/25.
//

import SwiftUI
import AVFoundation

@MainActor
final class CameraPreviewView: UIView {
    private var previewLayer: AVCaptureVideoPreviewLayer?

    override func layoutSubviews() {
        super.layoutSubviews()
        previewLayer?.frame = bounds
    }

    func setupPreviewLayer(with session: AVCaptureSession) {
        previewLayer?.removeFromSuperlayer()

        let newPreviewLayer = AVCaptureVideoPreviewLayer(session: session)
        newPreviewLayer.frame = bounds
        newPreviewLayer.videoGravity = .resizeAspectFill

        layer.addSublayer(newPreviewLayer)
        previewLayer = newPreviewLayer
    }
}

struct CameraPreviewViewRepresentable: UIViewRepresentable {
    let cameraManager: CameraManager

    func makeUIView(context: Context) -> CameraPreviewView {
        let previewView = CameraPreviewView()
        cameraManager.setupPreviewLayer(in: previewView)
        return previewView
    }

    func updateUIView(_ uiView: CameraPreviewView, context: Context) {}
}
