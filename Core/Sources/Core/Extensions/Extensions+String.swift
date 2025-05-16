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

    var toAmPmFormat: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")

        guard let date = dateFormatter.date(from: self) else {
            return self
        }

        dateFormatter.dateFormat = "h:mm a"
        dateFormatter.amSymbol = "am"
        dateFormatter.pmSymbol = "pm"
        return dateFormatter.string(from: date)
    }
}
