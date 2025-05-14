//
//  ToastView.swift
//  UIComponents
//
//  Created by Juan Carlos Hernandez Castillo on 13/05/25.
//

import SwiftUI
import Assets
import Core

public struct ToastView: View {
    @Binding private var message: String?
    @Binding private var type: ToastType
    @Binding private var isVisible: Bool

    public init(
        message: Binding<String?>,
        type: Binding<ToastType>,
        isVisible: Binding<Bool>
    ) {
        self._message = message
        self._type = type
        self._isVisible = isVisible
    }

    public var body: some View {
        VStack {
            Spacer()

            if isVisible, let message = message {
                HStack(alignment: .center, spacing: 15) {
                    Image(systemName: type == .error ? "xmark.octagon.fill" : "checkmark.circle.fill")
                        .foregroundColor(.white)
                        .font(.title2)

                    Text(message)
                        .font(.body)
                        .foregroundColor(.white)
                        .multilineTextAlignment(.leading)
                        .lineLimit(nil)
                }
                .padding()
                .frame(maxWidth: UIScreen.main.bounds.width * 0.85)
                .background(type == .error ? AppColor.error : AppColor.success)
                .cornerRadius(12)
                .shadow(color: AppColor.shadowColor.opacity(0.3), radius: 10, x: 0, y: 4)
                .transition(.move(edge: .bottom).combined(with: .opacity))
                .animation(.easeInOut, value: isVisible)
            }
        }
        .padding(.bottom, 30)
    }
}

