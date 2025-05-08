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

    public init(onTap: @escaping () -> Void) {
        self.onTap = onTap
    }

    public var body: some View {
        Image(systemName: "plus")
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
