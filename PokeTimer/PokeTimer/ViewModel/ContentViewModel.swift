//
//  ContentViewModel.swift
//  PokeTimer
//
//  Created by HUA Cindy on 25/02/2025.
//

import Foundation

@Observable
class ContentViewModel {
    var pokemonManager: PokemonManager
    var sessionManager: SessionManager
    
    var selectedDuration: Int = 1
    let durationOptions = Array(stride(from: 1, through: 20, by: 1))

    init(pokemonManager: PokemonManager, sessionManager: SessionManager) {
        self.pokemonManager = pokemonManager
        self.sessionManager = sessionManager
    }

    /// Saves all data when necessary
    func saveData() {
        PersistenceManager.shared.savePokemonManager(pokemonManager)
        PersistenceManager.shared.saveSessionManager(sessionManager)
    }
}
