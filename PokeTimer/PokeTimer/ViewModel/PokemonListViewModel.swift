//
//  PokemonListViewModel.swift
//  PokeTimer
//
//  Created by HUA Cindy on 26/02/2025.
//

import Foundation

class PokemonListViewModel: ObservableObject {
    @Published var pokemons: [Pokemon]
    @Published var currentPokemon: Pokemon?
    
    private let manager: PokemonManager
    
    init(manager: PokemonManager) {
        self.manager = manager
        self.pokemons = manager.pokemons
        self.currentPokemon = manager.currentPokemon
    }
    
    /// Selects a Pokémon as the active one.
    func selectPokemon(_ pokemon: Pokemon) {
        manager.selectPokemon(pokemon)
        self.currentPokemon = pokemon
    }
    
    /// Adds a new Pokémon to the list.
    func addPokemon() {
        let newPokemon = Pokemon(name: "New Pokémon \(pokemons.count + 1)")
        manager.addPokemon(newPokemon)
        self.pokemons = manager.pokemons // Sync the local list
    }
}
