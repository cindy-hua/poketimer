//
//  Pokemon.swift
//  PokeTimer
//
//  Created by HUA Cindy on 24/02/2025.
//

import Foundation

import SwiftUI

// MARK: - Pokemon Class
/// A class representing a Pokémon that logs focus sessions, tracks XP (in minutes), and computes its level.
class Pokemon: ObservableObject, Identifiable, Codable, Equatable, Hashable {
    var id = UUID()
    var name: String
    @Published var xp: Int         // Total XP (in minutes)
    @Published var level: Int
    @Published var sessions: [Session]
    
    // Coding keys for Codable conformance.
    enum CodingKeys: CodingKey {
        case id, name, xp, level, sessions
    }
    
    init(name: String) {
        self.name = name
        self.xp = 0
        self.level = 1
        self.sessions = []
    }
    
    /// Adds a new session, updates XP and recalculates the level.
    /// - Parameter session: A completed focus session.
    func addSession(_ session: Session) {
        sessions.append(session)
        // Convert session duration (seconds) to minutes.
        xp += session.duration / 60
        recalcLevel()
    }
    
    /// Recalculates the level based on XP.
    /// For example, every 16 minutes gives a level increase.
    private func recalcLevel() {
        level = 1 + xp / 16
    }
    
    // MARK: - Codable Conformance
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(UUID.self, forKey: .id)
        name = try container.decode(String.self, forKey: .name)
        xp = try container.decode(Int.self, forKey: .xp)
        level = try container.decode(Int.self, forKey: .level)
        sessions = try container.decode([Session].self, forKey: .sessions)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(name, forKey: .name)
        try container.encode(xp, forKey: .xp)
        try container.encode(level, forKey: .level)
        try container.encode(sessions, forKey: .sessions)
    }
    
    // MARK: - Equatable & Hashable
    static func == (lhs: Pokemon, rhs: Pokemon) -> Bool {
        return lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

// MARK: - Pokemon Manager
/// Manages a list of Pokémon and tracks the active one.
class PokemonManager: ObservableObject, Codable {
    @Published var pokemons: [Pokemon]
    @Published var currentPokemon: Pokemon?
    
    // Define coding keys for the properties you want to encode/decode.
    enum CodingKeys: String, CodingKey {
        case pokemons, currentPokemon
    }
    
    init() {
        let defaultPokemon = Pokemon(name: "Starter")
        self.pokemons = [defaultPokemon]
        self.currentPokemon = defaultPokemon
    }
    
    // MARK: - Codable Conformance
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        // Decode the array of Pokémon.
        self.pokemons = try container.decode([Pokemon].self, forKey: .pokemons)
        // Decode the current Pokémon if available.
        self.currentPokemon = try container.decodeIfPresent(Pokemon.self, forKey: .currentPokemon)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        // Encode the array of Pokémon.
        try container.encode(pokemons, forKey: .pokemons)
        // Encode the current Pokémon.
        try container.encode(currentPokemon, forKey: .currentPokemon)
    }
    
    // Additional manager functions...
    func addPokemon(_ pokemon: Pokemon) {
        pokemons.append(pokemon)
        if currentPokemon == nil {
            currentPokemon = pokemon
        }
    }
    
    func selectPokemon(_ pokemon: Pokemon) {
        currentPokemon = pokemon
    }
}
