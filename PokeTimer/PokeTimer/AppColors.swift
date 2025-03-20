//
//  AppColors.swift
//  PokeTimer
//
//  Created by HUA Cindy on 20/03/2025.
//

import SwiftUI

struct AppColors {
    // 🎨 Core Theme Colors
    static let primary = Color(hex: "#FF4F4F") // Classic Red
    static let secondary = Color(hex: "#FFD700") // Yellow
    static let background = Color(hex: "#FFF5BF") // Light Background
    static let accent = Color(hex: "#007BFF") // Blue Accent

    // 🌙 Dark Mode Colors
    static let darkPrimary = Color(hex: "#1E1E1E")
    static let darkSecondary = Color(hex: "#FFCC00")
    static let darkBackground = Color(hex: "#121212")
    static let darkAccent = Color(hex: "#30D5C8")

    // 🌟 Special Pokémon Type Colors
    static let firePrimary = Color(hex: "#FF5733")
    static let waterPrimary = Color(hex: "#007BFF")
}

// Extend Color to support hex values
extension Color {
    init(hex: String) {
        var hexSanitized = hex.trimmingCharacters(in: .whitespacesAndNewlines)
        hexSanitized = hexSanitized.replacingOccurrences(of: "#", with: "")

        var rgb: UInt64 = 0
        Scanner(string: hexSanitized).scanHexInt64(&rgb)

        let red = Double((rgb >> 16) & 0xFF) / 255.0
        let green = Double((rgb >> 8) & 0xFF) / 255.0
        let blue = Double(rgb & 0xFF) / 255.0
        let alpha: Double

        if hexSanitized.count == 8 { // Supports #RRGGBBAA
            alpha = Double((rgb >> 24) & 0xFF) / 255.0
        } else {
            alpha = 1.0 // Default to full opacity if no alpha is provided
        }

        self.init(red: red, green: green, blue: blue, opacity: alpha)
    }
}
