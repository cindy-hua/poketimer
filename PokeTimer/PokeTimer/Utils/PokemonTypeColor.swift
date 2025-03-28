//
//  PokemonTypeColor.swift
//  PokeTimer
//
//  Created by HUA Cindy on 21/03/2025.
//

import Foundation
import SwiftUI

/// A utility for assigning colors to Pokémon types.
struct PokemonTypeColor {
    static func color(for type: String) -> Color {
        switch type.lowercased() {
        case "normal": return Color.gray
        case "fire": return Color.red
        case "water": return Color.blue
        case "electric": return Color.yellow
        case "grass": return Color.green
        case "ice": return Color.cyan
        case "fighting": return Color.orange
        case "poison": return Color.purple
        case "ground": return Color.brown
        case "flying": return Color.teal
        case "psychic": return Color.pink
        case "bug": return Color.green.opacity(0.8)
        case "rock": return Color.brown.opacity(0.7)
        case "ghost": return Color.purple.opacity(0.6)
        case "dragon": return Color.indigo
        case "dark": return Color.black.opacity(0.8)
        case "steel": return Color.gray.opacity(0.7)
        case "fairy": return Color.pink.opacity(0.7)
        default: return Color.gray.opacity(0.5)  // Default for unknown types
        }
    }
}
