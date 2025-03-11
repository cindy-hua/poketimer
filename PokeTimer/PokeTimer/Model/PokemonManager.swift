//
//  PokemonManager.swift
//  PokeTimer
//
//  Created by HUA Cindy on 06/03/2025.
//

import Foundation

// MARK: - Pokemon Manager
/// Manages a list of Pokémon and tracks the active one.
@Observable
class PokemonManager: Codable, Equatable {
    var pokemons: [Pokemon]
    var currentPokemonID: UUID?

    init(pokemons: [Pokemon] = [], currentPokemonID: UUID? = nil) {
        self.pokemons = pokemons
        self.currentPokemonID = currentPokemonID
        
        // Automatically select first Pokémon if none is set
        if self.currentPokemonID == nil, let firstPokemon = pokemons.first {
            self.currentPokemonID = firstPokemon.id
            print("🐉 [DEBUG] Auto-selected first Pokémon: \(firstPokemon.name)")
        }
    }

    // MARK: - Codable Conformance
    enum CodingKeys: String, CodingKey {
        case pokemons, currentPokemonID
    }

    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        pokemons = try container.decode([Pokemon].self, forKey: .pokemons)
        currentPokemonID = try container.decodeIfPresent(UUID.self, forKey: .currentPokemonID)
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(pokemons, forKey: .pokemons)
        try container.encode(currentPokemonID, forKey: .currentPokemonID)
    }
    
/// Adds a new Pokémon to the list.
    func addPokemon(_ pokemon: Pokemon) {
        pokemons.append(pokemon)
        if currentPokemonID == nil {
            currentPokemonID = pokemon.id
            print("✨ [DEBUG] Auto-selected new Pokémon: \(pokemon.name)")
        }
    }

    /// Selects a Pokémon by its ID.
    func selectPokemon(by id: UUID) {
        if pokemons.contains(where: { $0.id == id }) {
            currentPokemonID = id
        }
    }

    /// Returns the currently selected Pokémon.
    func getCurrentPokemon() -> Pokemon? {
        return pokemons.first { $0.id == currentPokemonID }
    }

    /// Updates XP of the current Pokémon.
    func processCompletedSession(_ session: Session) {
        guard let index = pokemons.firstIndex(where: { $0.id == session.pokemonID }) else { return }
        let xpGained = session.duration / 60
        pokemons[index] = pokemons[index].gainingXP(xpGained)
    }
    
    static func == (lhs: PokemonManager, rhs: PokemonManager) -> Bool {
        return lhs.pokemons == rhs.pokemons && lhs.currentPokemonID == rhs.currentPokemonID
    }
}
