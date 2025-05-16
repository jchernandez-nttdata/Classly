//
//  CustomSelectableField.swift
//  UIComponents
//
//  Created by Juan Carlos Hernandez Castillo on 14/05/25.
//

import SwiftUI
import Assets

public struct CustomSelectableField: View {
    @Binding private var selectedItem: String?
    private let items: [String]
    private let placeholder: String
    private let isEnabled: Bool

    @State private var showSheet = false
    @State private var tempSelection: String?

    public init(
        selectedItem: Binding<String?>,
        items: [String],
        placeholder: String = "Select an option",
        isEnabled: Bool = true
    ) {
        self._selectedItem = selectedItem
        self.items = items
        self.placeholder = placeholder
        self.isEnabled = isEnabled
    }

    public var body: some View {
        Button(action: {
            guard isEnabled else { return }
            tempSelection = selectedItem ?? items.first
            showSheet.toggle()
        }) {
            HStack {
                Text(selectedItem ?? placeholder)
                    .foregroundColor(textColor())
                    .frame(maxWidth: .infinity, alignment: .leading)

                Spacer()

                Image(systemName: "chevron.down")
                    .foregroundColor(iconColor())
            }
            .padding(.vertical, 13)
            .padding(.horizontal, 15)
            .background(AppColor.background)
            .cornerRadius(16)
            .overlay(
                RoundedRectangle(cornerRadius: 16)
                    .stroke(AppColor.border, lineWidth: 1)
            )
        }
        .disabled(!isEnabled)
        .sheet(isPresented: $showSheet) {
            VStack(spacing: 0) {
                HStack {
                    Spacer()
                    Button("Done") {
                        selectedItem = tempSelection
                        showSheet = false
                    }
                    .padding(.all, 15)
                }

                Divider()

                Spacer()

                Picker("Select an option", selection: $tempSelection) {
                    ForEach(items, id: \.self) { item in
                        Text(item).tag(item)
                    }
                }
                .pickerStyle(.wheel)
                .labelsHidden()
                .frame(height: 250)

                Spacer()
            }
            .presentationDetents([.height(310)])
            .interactiveDismissDisabled(true)
            .padding(.all, 0)
        }
    }


    private func textColor() -> Color {
        if selectedItem == nil {
            return AppColor.disabledText
        } else {
            return isEnabled ? AppColor.primaryText : AppColor.disabledText
        }
    }

    private func iconColor() -> Color {
        return isEnabled ? AppColor.primaryText : AppColor.disabledText
    }
}


#Preview {
    VStack {
        CustomSelectableField(
            selectedItem: .constant(nil),
            items: (1...20).map { "Option \($0)" }
        )
        .padding()
    }
}
