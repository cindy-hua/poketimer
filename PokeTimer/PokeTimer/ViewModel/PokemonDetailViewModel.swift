//
//  PokemonDetailViewModel.swift
//  PokeTimer
//
//  Created by HUA Cindy on 26/02/2025.
//

import Foundation

class PokemonDetailViewModel: ObservableObject {
    @Published var pokemonName: String
    @Published var xp: Int
    @Published var level: Int
    @Published var sessions: [Session]

    private var pokemon: Pokemon

    init(pokemon: Pokemon) {
        self.pokemon = pokemon
        self.pokemonName = pokemon.name
        self.xp = pokemon.xp
        self.level = pokemon.level
        self.sessions = pokemon.sessions
    }

    /// Reloads Pokémon details (e.g., after XP changes).
    func refreshData() {
        self.pokemonName = pokemon.name
        self.xp = pokemon.xp
        self.level = pokemon.level
        self.sessions = pokemon.sessions
    }

    /// Formats a given date into a readable string.
    func formattedDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.timeStyle = .short
        return formatter.string(from: date)
    }
}
