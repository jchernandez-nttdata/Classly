//
//  CustomButton.swift
//  UIComponents
//
//  Created by Juan Carlos Hernandez Castillo on 28/04/25.
//

import SwiftUI
import Assets

public enum ButtonStyleType {
    case primary
    case outlined
}

public struct CustomButton: View {

    private var title: String
    private var style: ButtonStyleType
    private var cornerRadius: CGFloat
    private var height: CGFloat
    private var action: () -> Void
    private var isEnabled: Bool

    public init(
        title: String,
        style: ButtonStyleType = .primary,
        cornerRadius: CGFloat = 16,
        height: CGFloat = 50,
        action: @escaping () -> Void,
        isEnabled: Bool = true
    ) {
        self.title = title
        self.style = style
        self.cornerRadius = cornerRadius
        self.height = height
        self.action = action
        self.isEnabled = isEnabled
    }

    public var body: some View {
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
