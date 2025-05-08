//
//  CustomInputField.swift
//  UIComponents
//
//  Created by Juan Carlos Hernandez Castillo on 29/04/25.
//

import SwiftUI
import Assets

public enum InputFieldType {
    case normal
    case secure
}

public struct CustomTextField: View {
    private let placeholder: String
    private let type: InputFieldType
    private let leftIcon: Image?
    private let fieldBackgroundColor: Color
    @Binding private var text: String

    public init(
        placeholder: String,
        type: InputFieldType = .normal,
        text: Binding<String>,
        leftIcon: Image? = nil,
        fieldBackgroundColor: Color = AppColor.background
    ) {
        self.placeholder = placeholder
        self.type = type
        self._text = text
        self.leftIcon = leftIcon
        self.fieldBackgroundColor = fieldBackgroundColor
    }

    public var body: some View {
        HStack {
            if let icon = leftIcon {
                icon
                    .foregroundColor(AppColor.border)
            }

            Group {
                if type == .secure {
                    SecureField(placeholder, text: $text)
                } else {
                    TextField(placeholder, text: $text)
                }
            }
        }
        .padding(.vertical, 13)
        .padding(.horizontal, 15)
        .background(fieldBackgroundColor)
        .cornerRadius(16)
        .overlay(
            RoundedRectangle(cornerRadius: 16)
                .stroke(AppColor.border, lineWidth: 1)
        )
    }
}
