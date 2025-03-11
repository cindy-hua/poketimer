//
//  PokeTimerApp.swift
//  PokeTimer
//
//  Created by HUA Cindy on 24/02/2025.
//

import SwiftUI

@main
struct PokeTimerApp: App {
    @State var pokemonManager: PokemonManager
    @State var sessionManager: SessionManager

    init() {
//        PersistenceManager.shared.resetAllData()

        // Load fresh instances after reset
        pokemonManager = PersistenceManager.shared.loadPokemonManager()
        sessionManager = PersistenceManager.shared.loadSessionManager()
    }

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(pokemonManager)
                .environment(sessionManager)
                .onChange(of: pokemonManager.pokemons) { oldValue, newValue in
                    if oldValue != newValue {
                        PersistenceManager.shared.savePokemonManager(pokemonManager)
                    }
                }

                .onChange(of: sessionManager.sessions) { oldValue, newValue in
                    if oldValue != newValue {
                        PersistenceManager.shared.saveSessionManager(sessionManager)
                    }
                }
        }
    }
}
