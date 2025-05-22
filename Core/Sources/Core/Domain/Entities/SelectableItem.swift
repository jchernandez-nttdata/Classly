//
//  SelectableItem.swift
//  Core
//
//  Created by Juan Carlos Hernandez Castillo on 21/05/25.
//

public protocol SelectableItem: Identifiable, Hashable, Sendable {
    var displayName: String { get }
}

public struct EmptySelectableItem: SelectableItem {
    public var id: Int { 0 }
    let name: String

    public var displayName: String { name }

    public init (name: String = "") {
        self.name = name
    }
}
