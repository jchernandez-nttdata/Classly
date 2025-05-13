//
//  SwiftUIView.swift
//  UIComponents
//
//  Created by Juan Carlos Hernandez Castillo on 13/05/25.
//

import SwiftUI
import Assets

public struct CustomDateField: View {
    private let leftIcon: Image?
    @Binding private var date: Date

    public init(
        date: Binding<Date>,
        leftIcon: Image? = nil
    ) {
        self._date = date
        self.leftIcon = leftIcon
    }

    public var body: some View {
        HStack {
            Image(systemName: "calendar")
                .resizable()
                .frame(width: 18, height: 18)
                .scaledToFit()

            Text(date.formatted(.dateTime.day().month().year()))

        }
        .padding(.vertical, 13)
        .padding(.horizontal, 15)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(AppColor.background)
        .cornerRadius(16)
        .overlay(
            RoundedRectangle(cornerRadius: 16)
                .stroke(AppColor.border, lineWidth: 1)
        )
        .overlay {
            DatePicker(
                selection: $date,
                in: ...Date.now,
                displayedComponents: .date
            ) {}
                .labelsHidden()
                .scaleEffect(x: 4, y: 1)
                .colorMultiply(.clear)
        }
    }
}


#Preview {
    CustomDateField(date: .constant(.now))
}
