//
//  Pokemon.swift
//  PokeTimer
//
//  Created by HUA Cindy on 24/02/2025.
//

import Foundation

import SwiftUI

// MARK: - Pokemon Class
/// A struct representing a Pokémon that tracks XP (in minutes), and computes its level.
struct Pokemon: Identifiable, Codable, Equatable, Hashable {
    var id = UUID()
    var name: String
    var xp: Int         // Total XP (in minutes)
    var level: Int
    
    // Coding keys for Codable conformance.
    enum CodingKeys: CodingKey {
        case id, name, xp, level
    }
    
    init(name: String, xp: Int = 0) {
        self.name = name
        self.xp = xp
        self.level = Pokemon.calculateLevel(for: xp)
    }
    
    /// Recalculates the level based on XP.
    /// For example, every 16 minutes gives a level increase.
    static func calculateLevel(for xp: Int) -> Int {
        return 1 + xp / 16
    }
    
    /// Returns a new Pokemon instance with updated XP and level.
    func gainingXP(_ minutes: Int) -> Pokemon {
        var updated = self
        updated.xp += minutes
        updated.level = Pokemon.calculateLevel(for: updated.xp)
        return updated
    }
    
//    // MARK: - Equatable & Hashable
//    static func == (lhs: Pokemon, rhs: Pokemon) -> Bool {
//        return lhs.id == rhs.id
//    }
//    
//    func hash(into hasher: inout Hasher) {
//        hasher.combine(id)
//    }
}

