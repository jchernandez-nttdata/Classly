//
//  File.swift
//  Core
//
//  Created by Juan Carlos Hernandez Castillo on 20/05/25.
//

import Foundation

public extension Double {
    var formattedAsCurrency: String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.minimumFractionDigits = 2
        formatter.maximumFractionDigits = 2
        return formatter.string(from: NSNumber(value: self)) ?? "\(self)"
    }
}
