//
//  SessionViewModel.swift
//  PokeTimer
//
//  Created by HUA Cindy on 26/02/2025.
//

import Foundation

class SessionsViewModel: ObservableObject {
    private let pokemonManager: PokemonManager
    private let sessionManager: SessionManager

    init(pokemonManager: PokemonManager, sessionManager: SessionManager) {
        self.pokemonManager = pokemonManager
        self.sessionManager = sessionManager
    }

    /// Dynamically computes sessions grouped by Pokémon species.
    var sessionsByPokemon: [(PokemonSpeciesLegacy: PokemonSpeciesLegacy, sessions: [Session])] {
        pokemonManager.pokemons.map { pokemon in
            let sessions = sessionManager.getSessions(for: pokemon.id)
            return (PokemonSpeciesLegacy: pokemon.species, sessions: sessions)
        }
    }
}
