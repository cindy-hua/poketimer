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

    /// Dynamically computes sessions grouped by Pokémon name.
    var sessionsByPokemon: [(pokemonName: String, sessions: [Session])] {
        pokemonManager.pokemons.map { pokemon in
            let sessions = sessionManager.getSessions(for: pokemon.id)
            return (pokemonName: pokemon.name, sessions: sessions)
        }
    }
    
    /// Helper function to format dates.
    func formattedDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.timeStyle = .short
        return formatter.string(from: date)
    }
}
