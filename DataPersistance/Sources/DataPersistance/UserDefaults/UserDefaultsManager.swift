//
//  File.swift
//  DataPersistance
//
//  Created by Juan Carlos Hernandez Castillo on 8/05/25.
//

import Foundation

public final class UserDefaultsManager: UserDefaultsProtocol, @unchecked Sendable {

    public static let shared = UserDefaultsManager()

    //  https://developer.apple.com/documentation/foundation/userdefaults#Thread-Safety
    private let defaults: UserDefaults

    public init(defaults: UserDefaults = .standard) {
        self.defaults = defaults
    }

    public func set<T: Codable>(value: T, key: UserDefaultsKey) {
        defaults.setValue(value, forKey: key.rawValue)
    }

    public func get<T: Codable>(key: UserDefaultsKey) -> T? {
        defaults.value(forKey: key.rawValue) as? T
    }
}
