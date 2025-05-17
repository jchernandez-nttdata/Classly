//
//  AlertSheet.swift
//  UIComponents
//
//  Created by Juan Carlos Hernandez Castillo on 16/05/25.
//

import Assets
import SwiftUI

public struct AlertSheet: View {
    public var icon: Image
    public var title: String
    public var message: String
    public var confirmTitle: String
    public var cancelTitle: String
    public var onConfirm: () -> Void
    @Environment(\.dismiss) private var dismiss

    public init(
        icon: Image = Image(systemName: "exclamationmark.triangle.fill"),
        title: String,
        message: String,
        confirmTitle: String = "Confirm",
        cancelTitle: String = "Cancel",
        onConfirm: @escaping () -> Void
    ) {
        self.icon = icon
        self.title = title
        self.message = message
        self.confirmTitle = confirmTitle
        self.cancelTitle = cancelTitle
        self.onConfirm = onConfirm
    }

    public var body: some View {
        VStack(spacing: 20) {
            icon
                .resizable()
                .scaledToFit()
                .frame(width: 40, height: 40)
                .foregroundColor(AppColor.brandPrimary)

            Text(title)
                .font(AppFont.headline)
                .multilineTextAlignment(.center)

            Text(message)
                .font(AppFont.body)
                .multilineTextAlignment(.center)
                .foregroundColor(AppColor.secondaryText)

            HStack(spacing: 12) {
                CustomButton(title: cancelTitle, style: .outlined) {
                    dismiss()
                }

                CustomButton(title: confirmTitle) {
                    onConfirm()
                    dismiss()
                }
            }
        }
        .padding()
        .presentationDetents([.height(300)])
    }
}
