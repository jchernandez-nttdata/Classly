//
//  UserDefaultsProtocol.swift
//  DataPersistance
//
//  Created by Juan Carlos Hernandez Castillo on 8/05/25.
//

public protocol UserDefaultsProtocol: Sendable {
    func set<T: Codable>(value: T, key: UserDefaultsKey)
    func get<T: Codable>(key: UserDefaultsKey) -> T?
}
