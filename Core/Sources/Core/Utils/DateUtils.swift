//
//  DateUtils.swift
//  Core
//
//  Created by Juan Carlos Hernandez Castillo on 16/05/25.
//

import Foundation

public final class DateUtils {
    public static func formatDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_US")
        formatter.dateFormat = "EEEE, dd MMMM yyyy"

        let formatted = formatter.string(from: date)
        return formatted
    }
}
