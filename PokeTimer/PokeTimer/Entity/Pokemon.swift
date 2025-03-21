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
    let id: UUID
    var species: PokemonSpecies
    var xp: Int         // Total XP (in minutes)
    
    // Coding keys for Codable conformance.
    enum CodingKeys: CodingKey {
        case id, species, xp
    }
    
    init(id: UUID = UUID(), species: PokemonSpecies, xp: Int = 0) {
        self.id = id
        self.species = species
        self.xp = xp
    }
    
    var level: Int {
        return Pokemon.calculateLevel(for: xp)
    }
    
    /// Recalculates the level based on XP.
    /// For example, every 16 minutes gives a level increase.
    static func calculateLevel(for xp: Int) -> Int {
        return 1 + xp / 16
    }
    
    var sprite: String {
        return species.spriteFront
    }
    
    /// Returns a new Pokemon instance with updated XP and level.
    func gainingXP(_ minutes: Int) -> Pokemon {
        return Pokemon(id: self.id, species: self.species, xp: self.xp + minutes)
    }
    
    // MARK: - Equatable & Hashable
    static func == (lhs: Pokemon, rhs: Pokemon) -> Bool {
        return lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

