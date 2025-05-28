//
//  SectionTitle.swift
//  ClassesStudent
//
//  Created by Juan Carlos Hernandez Castillo on 28/05/25.
//

import SwiftUI
import Assets

struct SectionTitle: View {
    let title: String

    var body: some View {
        VStack(alignment: .leading) {
            Text(title)
                .font(AppFont.headline.weight(.regular))
                .foregroundStyle(AppColor.primaryText)
                .padding(.leading, 10)

            Divider()
        }
    }
}

#Preview {
    SectionTitle(title: "Monday")
}
