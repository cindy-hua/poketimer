//
//  PokemonListViewModel.swift
//  PokeTimer
//
//  Created by HUA Cindy on 26/02/2025.
//

import Foundation

@Observable
class PokemonListViewModel {
    private let pokemonManager: PokemonManager

    init(pokemonManager: PokemonManager) {
        self.pokemonManager = pokemonManager
    }
    
    /// Adds a new Pokémon to the list.
    func addPokemon() {
        let newPokemon = Pokemon(name: "New Pokémon \(pokemonManager.pokemons.count + 1)")
        pokemonManager.addPokemon(newPokemon)
        print("➕ [DEBUG] Added Pokémon: \(newPokemon.name)")
    }
}
