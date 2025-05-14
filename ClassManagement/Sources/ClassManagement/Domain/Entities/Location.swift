//
//  Location.swift
//  ClassManagement
//
//  Created by Juan Carlos Hernandez Castillo on 14/05/25.
//

import Foundation

public struct Location: Sendable, Identifiable, Hashable {
    public let id: Int
    public let locationName: String
    public let address: String
}
