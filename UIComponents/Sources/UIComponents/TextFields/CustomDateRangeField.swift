//
//  CustomDateRangeField.swift
//  UIComponents
//
//  Created by Juan Carlos Hernandez Castillo on 20/05/25.
//

import SwiftUI
import Assets

public struct CustomDateRangeField: View {
    @Binding private var startDate: Date
    @Binding private var endDate: Date

    public init(startDate: Binding<Date>, endDate: Binding<Date>) {
        self._startDate = startDate
        self._endDate = endDate
    }

    public var body: some View {
        HStack(spacing: 12) {
            singleDatePicker(
                icon: "calendar.badge.plus",
                date: $startDate,
                label: "Inicio",
                range: Date.distantPast...endDate
            )

            singleDatePicker(
                icon: "calendar.badge.minus",
                date: $endDate,
                label: "Fin",
                range: startDate...Date.now
            )
        }
    }

    private func singleDatePicker(
        icon: String,
        date: Binding<Date>,
        label: String,
        range: ClosedRange<Date>
    ) -> some View {
        HStack(spacing: 8) {
            Image(systemName: icon)
                .resizable()
                .frame(width: 18, height: 18)
                .scaledToFit()

            Text(date.wrappedValue.formatted(.dateTime.day().month().year()))
                .font(.system(size: 14))
                .foregroundStyle(AppColor.primaryText)
        }
        .padding(.vertical, 13)
        .padding(.horizontal, 15)
        .frame(maxWidth: .infinity)
        .background(AppColor.background)
        .cornerRadius(16)
        .overlay(
            RoundedRectangle(cornerRadius: 16)
                .stroke(AppColor.border, lineWidth: 1)
        )
        .overlay(
            DatePicker(
                "",
                selection: date,
                in: range,
                displayedComponents: .date
            )
            .labelsHidden()
            .scaleEffect(x: 2.5, y: 1)
            .colorMultiply(.clear)
        )
    }

}

#Preview {
    CustomDateRangeField(
        startDate: .constant(Calendar.current.date(byAdding: .day, value: -7, to: .now)!),
        endDate: .constant(.now)
    )
}
