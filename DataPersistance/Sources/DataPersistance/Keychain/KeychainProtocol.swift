//
//  KeychainProtocol.swift
//  DataPersistance
//
//  Created by Juan Carlos Hernandez Castillo on 8/05/25.
//

import Foundation

public protocol KeychainProtocol {
    func save(_ data: Data, for key: KeychainKey) throws
    func retrieve(for key: KeychainKey) throws -> Data?
    func delete(for key: KeychainKey) throws
}
