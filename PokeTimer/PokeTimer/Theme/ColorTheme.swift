//
//  ColorTheme.swift
//  PokeTimer
//
//  Created by HUA Cindy on 13/03/2025.
//

import Foundation
import SwiftUI

// Define a protocol for themes
protocol ColorTheme {
    var primary: Color { get }
    var secondary: Color { get }
    var background: Color { get }
    var accent: Color { get }
}

// Pokémon Classic Theme (Red & Yellow)
struct ClassicTheme: ColorTheme {
    let primary = Color(hex: "#FF4F4F")
    let secondary = Color(hex: "#FFD700")
    let background = Color(hex: "#F8F8F8")
    let accent = Color(hex: "#007BFF")
}

// Dark Mode Theme
struct DarkTheme: ColorTheme {
    let primary = Color(hex: "#1E1E1E")
    let secondary = Color(hex: "#FFCC00")
    let background = Color(hex: "#121212")
    let accent = Color(hex: "#30D5C8")
}

// Pokémon Type Themes (Optional)
struct FireTheme: ColorTheme {
    let primary = Color(hex: "#FF5733")
    let secondary = Color(hex: "#FFC300")
    let background = Color(hex: "#1E1E1E")
    let accent = Color(hex: "#FF5733")
}

struct WaterTheme: ColorTheme {
    let primary = Color(hex: "#007BFF")
    let secondary = Color(hex: "#00CFFF")
    let background = Color(hex: "#1E1E1E")
    let accent = Color(hex: "#007BFF")
}

// Extend Color to support hex values
extension Color {
    init(hex: String) {
        let scanner = Scanner(string: hex)
        scanner.currentIndex = hex.startIndex
        var rgbValue: UInt64 = 0
        scanner.scanHexInt64(&rgbValue)

        let red = Double((rgbValue >> 16) & 0xFF) / 255.0
        let green = Double((rgbValue >> 8) & 0xFF) / 255.0
        let blue = Double(rgbValue & 0xFF) / 255.0

        self.init(red: red, green: green, blue: blue)
    }
}
