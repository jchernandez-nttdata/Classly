//
//  Extensions+View.swift
//  Core
//
//  Created by Juan Carlos Hernandez Castillo on 28/04/25.
//

import SwiftUI

public extension View {
    func padding(
        top: CGFloat = 0,
        bottom: CGFloat = 0,
        left: CGFloat = 0,
        right: CGFloat = 0
    ) -> some View {
        self.padding(.top, top)
            .padding(.bottom, bottom)
            .padding(.leading, left)
            .padding(.trailing, right)
    }

    func loadingIndicator(_ isShowing: Bool) -> some View {
        self.modifier(LoadingIndicator(isShowing: isShowing))
    }

    func removeFocusOnTap() -> some View {
        modifier(RemoveFocusOnTapModifier())
    }
}
