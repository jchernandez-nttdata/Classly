//
//  File.swift
//  ClassesStudent
//
//  Created by Juan Carlos Hernandez Castillo on 31/05/25.
//

@preconcurrency import AVFoundation
import SwiftUI

@MainActor
final class CameraManager: NSObject, ObservableObject {
    @Published var permissionGranted = false
    @Published var permissionDenied = false
    @Published var isSessionRunning = false
    @Published var scannedCode: String?

    private var captureSession: AVCaptureSession?
    private var metadataOutput: AVCaptureMetadataOutput?

    override init() {
        super.init()
    }

    func requestCameraPermission() async {
        let status = AVCaptureDevice.authorizationStatus(for: .video)

        switch status {
        case .authorized:
            self.permissionGranted = true
            await self.setupCamera()
        case .notDetermined:
            let granted = await AVCaptureDevice.requestAccess(for: .video)
            if granted {
                self.permissionGranted = true
                await self.setupCamera()
            } else {
                self.permissionDenied = true
            }
        case .denied, .restricted:
            self.permissionDenied = true
        @unknown default:
            self.permissionDenied = true
        }
    }

    private func setupCamera() async {
        guard permissionGranted else { return }

        let session = AVCaptureSession()

        do {
            // Configure session
            session.beginConfiguration()

            // Add video input
            guard let videoDevice = AVCaptureDevice.default(.builtInWideAngleCamera,
                                                            for: .video,
                                                            position: .back) else {
                session.commitConfiguration()
                return
            }

            let videoInput = try AVCaptureDeviceInput(device: videoDevice)

            guard session.canAddInput(videoInput) else {
                session.commitConfiguration()
                return
            }

            session.addInput(videoInput)

            // Add metadata output for QR codes
            let metadataOutput = AVCaptureMetadataOutput()
            if session.canAddOutput(metadataOutput) {
                session.addOutput(metadataOutput)
                metadataOutput.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
                metadataOutput.metadataObjectTypes = [.qr, .ean8, .ean13, .pdf417, .code128]
                self.metadataOutput = metadataOutput
            }

            session.commitConfiguration()
            self.captureSession = session

            // Start session on background thread
            await withCheckedContinuation { continuation in
                DispatchQueue.global(qos: .userInitiated).async {
                    session.startRunning()
                    Task { @MainActor in
                        self.isSessionRunning = true
                        continuation.resume()
                    }
                }
            }

        } catch {
            print("Error setting up camera: \(error)")
        }
    }

    func startSession() async {
        guard let captureSession = captureSession,
              !captureSession.isRunning else { return }

        await withCheckedContinuation { continuation in
            DispatchQueue.global(qos: .userInitiated).async {
                captureSession.startRunning()
                Task { @MainActor in
                    self.isSessionRunning = true
                    continuation.resume()
                }
            }
        }
    }

    func stopSession() async {
        guard let captureSession = captureSession,
              captureSession.isRunning else { return }

        await withCheckedContinuation { continuation in
            DispatchQueue.global(qos: .userInitiated).async {
                captureSession.stopRunning()
                Task { @MainActor in
                    self.isSessionRunning = false
                    continuation.resume()
                }
            }
        }
    }

    func setupPreviewLayer(in previewView: CameraPreviewView) {
        if let captureSession = captureSession {
            previewView.setupPreviewLayer(with: captureSession)
        }
    }

    nonisolated func handleScannedCode(_ code: String) {
        Task { @MainActor in
            // Provide haptic feedback
            let impactFeedback = UIImpactFeedbackGenerator(style: .medium)
            impactFeedback.impactOccurred()

            self.scannedCode = code
            
            await self.stopSession()
        }
    }
}

// MARK: - Metadata Output Delegate
extension CameraManager: AVCaptureMetadataOutputObjectsDelegate {
    nonisolated func metadataOutput(_ output: AVCaptureMetadataOutput,
                                    didOutput metadataObjects: [AVMetadataObject],
                                    from connection: AVCaptureConnection) {

        guard let metadataObject = metadataObjects.first,
              let readableObject = metadataObject as? AVMetadataMachineReadableCodeObject,
              let stringValue = readableObject.stringValue else { return }

        handleScannedCode(stringValue)
    }
}
