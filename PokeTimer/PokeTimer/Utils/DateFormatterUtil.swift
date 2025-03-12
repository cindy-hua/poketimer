//
//  DateFormatterUtil.swift
//  PokeTimer
//
//  Created by HUA Cindy on 12/03/2025.
//

import Foundation

struct DateFormatterUtil {
    /// Formats a given date into a readable string.
    static func formattedDate(_ date: Date, format: String = "MMM d, yyyy") -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        return formatter.string(from: date)
    }
}
