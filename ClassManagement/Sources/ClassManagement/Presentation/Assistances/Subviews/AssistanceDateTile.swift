//
//  AssistanceDateTile.swift
//  ClassManagement
//
//  Created by Juan Carlos Hernandez Castillo on 16/05/25.
//

import SwiftUI
import Assets

struct AssistanceDateTile: View {
    let date: String
    let onSelect: () -> Void

    var body: some View {
        HStack {
            Text(date)
                .font(AppFont.body.bold())
                .padding(.bottom, 1)

            Spacer()

            Image(systemName: "chevron.right")
        }
        .frame(maxWidth: .infinity)
        .contentShape(Rectangle())
        .onTapGesture(perform: onSelect)
    }
}

#Preview {
    AssistanceDateTile(
        date: "Monday, 7 May", onSelect: {}
    )
}
