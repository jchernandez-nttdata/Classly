//
//  File.swift
//  Core
//
//  Created by Juan Carlos Hernandez Castillo on 7/05/25.
//

import Foundation

public enum DateFormat: String {
    case iso8601 = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
    case onlyDate = "yyyy-MM-dd"
}

public extension String {
    func toDate(format: DateFormat = .onlyDate) -> Date? {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_US_POSIX")
        if format == .iso8601 {
            formatter.timeZone = TimeZone(secondsFromGMT: 0)
        }
        formatter.dateFormat = format.rawValue
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
