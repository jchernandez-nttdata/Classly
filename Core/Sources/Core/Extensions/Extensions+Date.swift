//
//  File.swift
//  Core
//
//  Created by Juan Carlos Hernandez Castillo on 13/05/25.
//

import Foundation

public extension Date {
    func toString(format: String = "yyyy-MM-dd") -> String {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.dateFormat = format
        return formatter.string(from: self)
    }
}
