//
//  Colors.swift
//  Assets
//
//  Created by Juan Carlos Hernandez Castillo on 28/04/25.
//

import SwiftUI

public enum AppColor {
    case brandPrimary
    case brandAccent
    case background
    case secondaryBackground
    case elevatedSurface
    case primaryText
    case secondaryText
    case disabledText
    case border
    case shadowColor
    case success
    case error
    case warning

    public var color: Color {
        switch self {
        case .brandPrimary:
            return Color(.brandPrimary)
        case .brandAccent:
            return Color(.brandAccent)
        case .background:
            return Color(.background)
        case .secondaryBackground:
            return Color(.secondaryBackground)
        case .elevatedSurface:
            return Color(.elevatedSurface)
        case .primaryText:
            return Color(.primaryText)
        case .secondaryText:
            return Color(.secondaryText)
        case .disabledText:
            return Color(.disabledText)
        case .border:
            return Color(.border)
        case .shadowColor:
            return Color(.shadow)
        case .success:
            return Color(.success)
        case .error:
            return Color(.error)
        case .warning:
            return Color(.warning)
        }
    }
}
