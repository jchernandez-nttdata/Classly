//
//  File.swift
//  Core
//
//  Created by Juan Carlos Hernandez Castillo on 8/05/25.
//

import SwiftUI

public class UserSession: ObservableObject {

    public init(id: Int, email: String, name: String) {
        self.id = id
        self.email = email
        self.name = name
    }

    public var id: Int
    public var email: String
    public var name: String
}
