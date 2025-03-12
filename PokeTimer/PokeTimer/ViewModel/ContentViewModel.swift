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
    private let persistenceManager: PersistenceManager
    
    var selectedDuration: Int = 1
    let durationOptions = Array(stride(from: 1, through: 20, by: 1))

    init(pokemonManager: PokemonManager, sessionManager: SessionManager, persistenceManager: PersistenceManager = .shared) {
        self.pokemonManager = pokemonManager
        self.sessionManager = sessionManager
        self.persistenceManager = persistenceManager
    }

    /// Saves all data when necessary
    func saveData() {
        persistenceManager.savePokemonManager(pokemonManager)
        persistenceManager.saveSessionManager(sessionManager)
    }
}
