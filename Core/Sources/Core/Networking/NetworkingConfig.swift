//
//  File.swift
//  Core
//
//  Created by Juan Carlos Hernandez Castillo on 29/04/25.
//
import ClasslyNetworking

public extension Request {
    var baseURL: String {
        "http://192.168.1.5:3000"
    }

    var headers: [String: String?] {
        ["Content-Type": "application/json"]
    }

    var params: [String: String]? { nil }

    var validStatusCodes: [Int] {
        [200, 201]
    }
}
