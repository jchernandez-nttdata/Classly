//
//  File.swift
//  Authentication
//
//  Created by Juan Carlos Hernandez Castillo on 28/04/25.
//

import SwiftUI
import Assets

enum ButtonStyleType {
    case primary
    case outlined
}

struct CustomButton: View {

    var title: String
    var style: ButtonStyleType = .primary
    var cornerRadius: CGFloat = 16
    var height: CGFloat = 50
    var action: () -> Void
    var isEnabled: Bool = true

    var body: some View {
        Text(title)
            .font(AppFont.callout)
            .foregroundColor(getTextColor())
            .padding()
            .frame(maxWidth: .infinity)
            .background(getBackgroundColor())
            .cornerRadius(cornerRadius)
            .overlay(getOverlay())
            .onTapGesture {
                if isEnabled {
                    action()
                }
            }
    }

    private func getTextColor() -> Color {
        if style == .outlined {
            return AppColor.brandPrimary
        } else {
            return AppColor.background
        }
    }

    private func getBackgroundColor() -> Color {
        if style == .primary {
            return AppColor.brandPrimary
        } else {
            return Color.clear
        }
    }

    private func getOverlay() -> some View {
        if style == .outlined {
            return AnyView(RoundedRectangle(cornerRadius: cornerRadius)
                .stroke(AppColor.brandPrimary, lineWidth: 2))
        } else {
            return AnyView(EmptyView())
        }
    }
}
