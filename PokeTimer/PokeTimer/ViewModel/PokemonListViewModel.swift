//
//  PokemonListViewModel.swift
//  PokeTimer
//
//  Created by HUA Cindy on 26/02/2025.
//

import Foundation

class PokemonListViewModel: ObservableObject {
    @Published var pokemons: [Pokemon] = []
    @Published var currentPokemon: Pokemon?
    private let manager: PokemonManager
    
    init(manager: PokemonManager) {
        self.manager = manager
    }
    
    /// Syncs with the manager on appear
    func updateData() {
        self.objectWillChange.send()
    }
    
    /// Selects a Pokémon as the active one.
    func selectPokemon(_ pokemon: Pokemon) {
        manager.selectPokemon(pokemon)
        updateData()
    }
    
    /// Adds a new Pokémon to the list.
    func addPokemon() {
        let newPokemon = Pokemon(name: "New Pokémon \(pokemons.count + 1)")
        manager.addPokemon(newPokemon)
        updateData()
    }
}
