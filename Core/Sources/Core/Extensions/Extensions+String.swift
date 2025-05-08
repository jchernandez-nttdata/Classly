//
//  File.swift
//  Core
//
//  Created by Juan Carlos Hernandez Castillo on 7/05/25.
//

import Foundation

public extension String {
    func toDate(format: String = "yyyy-MM-dd") -> Date? {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.dateFormat = format
        return formatter.date(from: self)
    }
}
