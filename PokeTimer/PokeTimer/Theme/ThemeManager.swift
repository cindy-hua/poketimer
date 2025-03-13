//
//  ThemeManager.swift
//  PokeTimer
//
//  Created by HUA Cindy on 13/03/2025.
//

import Foundation
import SwiftUI

@Observable
class ThemeManager {
    var currentTheme: ColorTheme = ClassicTheme() // Default theme

    func switchTheme(to theme: ColorTheme) {
        self.currentTheme = theme
    }
}

// Define an environment key for ThemeManager
private struct ThemeManagerKey: EnvironmentKey {
    static let defaultValue = ThemeManager()
}

// Extend EnvironmentValues to use ThemeManager
extension EnvironmentValues {
    var themeManager: ThemeManager {
        get { self[ThemeManagerKey.self] }
        set { self[ThemeManagerKey.self] = newValue }
    }
}
