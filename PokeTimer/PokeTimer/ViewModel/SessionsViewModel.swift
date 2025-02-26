//
//  SessionViewModel.swift
//  PokeTimer
//
//  Created by HUA Cindy on 26/02/2025.
//

import Foundation

class SessionViewModel: ObservableObject {
    @Published var sessionsByPokemon: [(pokemonName: String, sessions: [Session])]
    
    init(manager: PokemonManager) {
        self.sessionsByPokemon = manager.pokemons.map { pokemon in
            (pokemonName: pokemon.name, sessions: pokemon.sessions)
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
