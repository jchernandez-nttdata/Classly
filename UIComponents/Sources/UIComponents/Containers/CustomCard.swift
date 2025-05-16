//
//  CustomCard.swift
//  UIComponents
//
//  Created by Juan Carlos Hernandez Castillo on 15/05/25.
//

import SwiftUI
import Assets

public struct CustomCard<Content: View>: View {
    private let content: Content

    public init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }

    public var body: some View {
        content
            .padding()
            .background(AppColor.elevatedSurface)
            .cornerRadius(12)
            .shadow(color: Color.black.opacity(0.1), radius: 4, x: 0, y: 2)
    }
}
