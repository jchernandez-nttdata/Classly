//
//  File.swift
//  Core
//
//  Created by Juan Carlos Hernandez Castillo on 8/05/25.
//

import SwiftUI

public final class UserSession: ObservableObject, Sendable {

    public init(id: Int, email: String, name: String) {
        self.id = id
        self.email = email
        self.name = name
    }

    public let id: Int
    public let email: String
    public let name: String
}
