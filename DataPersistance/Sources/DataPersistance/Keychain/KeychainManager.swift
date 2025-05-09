//
//  File.swift
//  DataPersistance
//
//  Created by Juan Carlos Hernandez Castillo on 8/05/25.
//

import Foundation

public final class KeychainManager: KeychainProtocol {

    public init() {
        
    }

    public func save(_ data: Data, for key: KeychainKey) throws {
        let query = [
            kSecClass: kSecClassGenericPassword,
            kSecAttrAccount: key.rawValue,
            kSecValueData: data
        ] as CFDictionary

        SecItemDelete(query)
        let status = SecItemAdd(query, nil)
        guard status == errSecSuccess else { throw KeychainError.unhandledError(status) }
    }

    public func retrieve(for key: KeychainKey) throws -> Data? {
        let query = [
            kSecClass: kSecClassGenericPassword,
            kSecAttrAccount: key.rawValue,
            kSecReturnData: true,
            kSecMatchLimit: kSecMatchLimitOne
        ] as CFDictionary

        var result: AnyObject?
        let status = SecItemCopyMatching(query, &result)
        if status == errSecItemNotFound { return nil }
        guard status == errSecSuccess else { throw KeychainError.unhandledError(status) }

        return result as? Data
    }

    public func delete(for key: KeychainKey) throws {
        let query = [
            kSecClass: kSecClassGenericPassword,
            kSecAttrAccount: key.rawValue
        ] as CFDictionary

        let status = SecItemDelete(query)
        guard status == errSecSuccess || status == errSecItemNotFound else {
            throw KeychainError.unhandledError(status)
        }
    }
}

public enum KeychainError: Error {
    case unhandledError(OSStatus)
}
