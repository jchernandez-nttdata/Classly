//
//  File.swift
//  UIComponents
//
//  Created by Juan Carlos Hernandez Castillo on 16/05/25.
//

import Assets
import SwiftUI
import Core

public struct CustomSearchableField<T: SelectableItem>: View {
    // MARK: - Props
    private let placeholder: String
    private let onQueryChanged: (String) async -> [T]
    private let leftIcon: Image?

    @Binding private var selectedItem: T?
    @State private var query: String = ""
    @State private var results: [T] = []
    @State private var isSearching = false

    // Debounce
    private let debounceTime: TimeInterval = 0.3
    @State private var debounceTask: Task<Void, Never>?

    // Focus
    @FocusState private var isFocused: Bool
    @State private var isProgrammaticChange = false

    // MARK: - Init
    public init(
        placeholder: String,
        selectedItem: Binding<T?>,
        leftIcon: Image? = nil,
        onQueryChanged: @escaping (String) async -> [T]
    ) {
        self.placeholder = placeholder
        self._selectedItem = selectedItem
        self.leftIcon = leftIcon
        self.onQueryChanged = onQueryChanged
    }

    // MARK: - View
    public var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            // TextField con icono opcional
            HStack {
                if let icon = leftIcon {
                    icon.foregroundColor(AppColor.border)
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

            // Lista de resultados
            if isSearching && !results.isEmpty {
                VStack(alignment: .leading, spacing: 0) {
                    ForEach(results) { result in
                        Button {
                            // Seleccionar elemento
                            isProgrammaticChange = true
                            selectedItem = result
                            query = result.displayName
                            results.removeAll()
                            isSearching = false
                            isFocused = false
                        } label: {
                            Text(result.displayName)
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
        .onAppear {
            // Si llega pre-seleccionado, muestra el nombre
            if let item = selectedItem {
                query = item.displayName
            }
        }
    }

    // MARK: - Logic
    private func handleQueryChange(_ newValue: String) {
        guard !newValue.isEmpty else { return }

        // Evita disparar de nuevo cuando seteas query programáticamente
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
            await MainActor.run {
                results = fetched
            }
        }
    }
}
