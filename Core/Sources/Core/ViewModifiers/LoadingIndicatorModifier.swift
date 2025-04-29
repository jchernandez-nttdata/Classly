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
        ZStack {
            content
            if isShowing {
                loadingView
            }
        }
    }

    private var loadingView: some View {
        ZStack {
            Color(white: 0.0, opacity: 0.5)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .edgesIgnoringSafeArea(.all)
            ProgressView()
                .progressViewStyle(CircularProgressViewStyle(tint: .white))
                .scaleEffect(2)
        }
        .ignoresSafeArea()
        .transition(AnyTransition.opacity.animation(.easeInOut(duration: 0.2)))
    }
}

