//
//  RemoveFocusOnTapModifier.swift
//  Core
//
//  Created by Juan Carlos Hernandez Castillo on 13/05/25.
//

import SwiftUI

public struct RemoveFocusOnTapModifier: ViewModifier {
    public func body(content: Content) -> some View {
        content
            .onTapGesture {
                UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to:nil, from:nil, for:nil)
            }
    }
}
