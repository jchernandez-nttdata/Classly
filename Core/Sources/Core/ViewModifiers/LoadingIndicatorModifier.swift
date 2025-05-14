//
//  File.swift
//  Core
//
//  Created by Juan Carlos Hernandez Castillo on 29/04/25.
//

import SwiftUI

struct LoadingIndicator: ViewModifier {
    var isShowing: Bool

    func body(content: Content) -> some View {
        content
            .overlay(
                Group {
                    if isShowing {
                        ZStack {
                            Color.black.opacity(0.5)
                                .ignoresSafeArea()
                            ProgressView()
                                .progressViewStyle(CircularProgressViewStyle(tint: .white))
                                .scaleEffect(2)
                        }
                        .transition(.opacity)
                        .animation(.easeInOut(duration: 0.2), value: isShowing)
                    }
                }
            )
    }
}


