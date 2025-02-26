//
//  SessionViewModel.swift
//  PokeTimer
//
//  Created by HUA Cindy on 26/02/2025.
//

import Foundation

class SessionsViewModel: ObservableObject {
    @Published var sessionsByPokemon: [(pokemonName: String, sessions: [Session])]
    
    private var manager: PokemonManager
    
    init(manager: PokemonManager) {
        self.manager = manager
        self.sessionsByPokemon = manager.pokemons.map { pokemon in
            (pokemonName: pokemon.name, sessions: pokemon.sessions)
        }
    }

    /// Reloads session data when Pokémon sessions change.
    func loadSessions() {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.sessionsByPokemon = self.manager.pokemons.map { pokemon in
                (pokemonName: pokemon.name, sessions: pokemon.sessions)
            }
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
