//
//  PokemonDetailViewModel.swift
//  PokeTimer
//
//  Created by HUA Cindy on 11/03/2025.
//

import Foundation

@Observable
class PokemonDetailViewModel {
    private let pokemonManager: PokemonManager
    private let sessionManager: SessionManager
    private let pokemonID: UUID

    init(pokemonManager: PokemonManager, sessionManager: SessionManager, pokemonID: UUID) {
        self.pokemonManager = pokemonManager
        self.sessionManager = sessionManager
        self.pokemonID = pokemonID
    }
    
    /// Computed property to get the Pokémon dynamically from `PokemonManager`
    var pokemon: Pokemon? {
        pokemonManager.pokemons.first(where: { $0.id == pokemonID })
    }

    /// Computed property for Pokémon name
    var pokemonName: String {
        pokemon?.name ?? "Unknown"
    }

    /// Computed property for XP
    var xp: Int {
        pokemon?.xp ?? 0
    }

    /// Computed property for level
    var level: Int {
        pokemon?.level ?? 1
    }

    /// Fetch sessions related to this Pokémon
    var sessions: [Session] {
        sessionManager.getSessions(for: pokemonID)
    }
}
