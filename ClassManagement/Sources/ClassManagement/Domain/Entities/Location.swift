//
//  Location.swift
//  ClassManagement
//
//  Created by Juan Carlos Hernandez Castillo on 14/05/25.
//

import Foundation
import Core

public struct Location: Sendable, Hashable {
    public let id: Int
    public let name: String
    public let address: String
}

extension Location: SelectableItem {
    public var displayName: String { name }
}
