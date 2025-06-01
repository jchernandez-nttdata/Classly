//
//  CircularButton.swift
//  UIComponents
//
//  Created by Juan Carlos Hernandez Castillo on 7/05/25.
//

import SwiftUI
import Assets

public struct CircularButton: View {

    private let onTap: () -> Void
    private let systemName: String

    public init(
        onTap: @escaping () -> Void,
        systemName: String = "plus"
    ) {
        self.onTap = onTap
        self.systemName = systemName
    }

    public var body: some View {
        Image(systemName: systemName)
            .font(.title.weight(.semibold))
            .padding()
            .background(AppColor.brandPrimary)
            .foregroundColor(.white)
            .clipShape(Circle())
            .padding()
            .onTapGesture(perform: onTap)
    }
}

#Preview {
    CircularButton(onTap: {})
}
