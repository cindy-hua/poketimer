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
    private let persistenceManager: PersistenceManager

    init(pokemons: [Pokemon] = [], currentPokemonID: UUID? = nil, persistenceManager: PersistenceManager = .shared) {
        self.pokemons = pokemons
        self.currentPokemonID = currentPokemonID
        self.persistenceManager = persistenceManager
        
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
        self.persistenceManager = .shared
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(pokemons, forKey: .pokemons)
        try container.encodeIfPresent(currentPokemonID, forKey: .currentPokemonID)
    }
    
/// Adds a new Pokémon to the list.
    func addPokemon(_ pokemon: Pokemon) {
        pokemons.append(pokemon)
        if currentPokemonID == nil {
            currentPokemonID = pokemon.id
            print("✨ [DEBUG] Auto-selected new Pokémon: \(pokemon.name)")
        }
        savePokemonData()
    }

    /// Selects a Pokémon by its ID.
    func selectPokemon(by id: UUID) {
        if pokemons.contains(where: { $0.id == id }) {
            currentPokemonID = id
            savePokemonData()
        }
    }
    
    /// Saves the Pokémon list and current selection to disk.
    private func savePokemonData() {
        persistenceManager.savePokemonManager(self)
    }

    /// Returns the currently selected Pokémon.
    func getCurrentPokemon() -> Pokemon? {
        return pokemons.first { $0.id == currentPokemonID }
    }

    /// Updates XP of the current Pokémon.
    func processCompletedSession(_ session: Session) {
        guard let index = pokemons.firstIndex(where: { $0.id == session.pokemonID }) else { return }
        
        let xpGained = session.durationInMinutes
        pokemons[index] = pokemons[index].gainingXP(xpGained)

        print("⚡️ [DEBUG] XP Updated: \(pokemons[index].xp) for \(pokemons[index].name)")

        savePokemonData()
    }
    
    static func == (lhs: PokemonManager, rhs: PokemonManager) -> Bool {
        return lhs.pokemons == rhs.pokemons && lhs.currentPokemonID == rhs.currentPokemonID
    }
}
