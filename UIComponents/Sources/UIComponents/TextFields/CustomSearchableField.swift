//
//  File.swift
//  UIComponents
//
//  Created by Juan Carlos Hernandez Castillo on 16/05/25.
//

import Assets
import SwiftUI

public struct CustomSearchableField: View {
    private let placeholder: String
    private let onQueryChanged: (String) async -> [String]
    private let leftIcon: Image?

    @Binding private var selectedItem: String
    @State private var query: String = ""
    @State private var results: [String] = []
    @State private var isSearching = false

    private let debounceTime: TimeInterval = 0.3
    @State private var debounceTask: Task<Void, Never>?
    @FocusState private var isFocused: Bool
    @State private var isProgrammaticChange = false

    public init(
        placeholder: String,
        selectedItem: Binding<String>,
        leftIcon: Image? = nil,
        onQueryChanged: @escaping (String) async -> [String]
    ) {
        self.placeholder = placeholder
        self._selectedItem = selectedItem
        self.leftIcon = leftIcon
        self.onQueryChanged = onQueryChanged
    }

    public var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            HStack {
                if let icon = leftIcon {
                    icon
                        .foregroundColor(AppColor.border)
                }

                TextField(placeholder, text: $query)
                    .focused($isFocused)
                    .onChange(of: query, perform: handleQueryChange)
            }
            .padding(.vertical, 13)
            .padding(.horizontal, 15)
            .background(AppColor.background)
            .cornerRadius(16)
            .overlay(
                RoundedRectangle(cornerRadius: 16)
                    .stroke(AppColor.border, lineWidth: 1)
            )

            if isSearching && !results.isEmpty {
                VStack(alignment: .leading, spacing: 0) {
                    ForEach(results, id: \.self) { result in
                        Button(action: {
                            isProgrammaticChange = true
                            selectedItem = result
                            query = result
                            results = []
                            isSearching = false
                            isFocused = false
                        }) {
                            Text(result)
                                .padding()
                                .frame(maxWidth: .infinity, alignment: .leading)
                        }
                        Divider()
                    }
                }
                .background(AppColor.elevatedSurface)
                .cornerRadius(12)
                .shadow(color: AppColor.shadowColor.opacity(0.2), radius: 4, x: 0, y: 2)
                .padding(.horizontal, 4)
            }
        }
    }

    private func handleQueryChange(_ newValue: String) {
        guard !newValue.isEmpty else { return }
        if isProgrammaticChange {
            isProgrammaticChange = false
            return
        }
        isSearching = true
        debounceTask?.cancel()

        debounceTask = Task {
            try? await Task.sleep(nanoseconds: UInt64(debounceTime * 1_000_000_000))
            guard !Task.isCancelled else { return }
            let fetched = await onQueryChanged(newValue)
            results = fetched
        }
    }
}
