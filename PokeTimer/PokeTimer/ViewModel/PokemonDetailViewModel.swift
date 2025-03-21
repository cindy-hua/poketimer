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

    var pokemonSpecies: PokemonSpecies?

    init(pokemonManager: PokemonManager, sessionManager: SessionManager, pokemonID: UUID) {
        self.pokemonManager = pokemonManager
        self.sessionManager = sessionManager
        self.pokemonID = pokemonID
        Task { await fetchPokemonDetails() }
    }

    /// Computed property to get the Pokémon from `PokemonManager`
    var pokemon: Pokemon? {
        pokemonManager.pokemons.first(where: { $0.id == pokemonID })
    }

    /// Fetch Pokémon details from API
    func fetchPokemonDetails() async {
        guard let pokemon = pokemon else { return }
        do {
            let species = try await PokemonAPI.shared.fetchCompletePokemonData(name: pokemon.species.rawValue)
            await MainActor.run { self.pokemonSpecies = species }
        } catch {
            print("Failed to fetch Pokémon details: \(error)")
        }
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
