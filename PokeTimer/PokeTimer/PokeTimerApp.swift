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
    @State var themeManager = ThemeManager()

    init() {
//        PersistenceManager.shared.resetAllData()
        let persistenceManager = PersistenceManager()

        // Load fresh instances after reset
        pokemonManager = persistenceManager.loadPokemonManager()
        sessionManager = persistenceManager.loadSessionManager()
    }

    var body: some Scene {
        WindowGroup {
            ContentView(pokemonManager: pokemonManager, sessionManager: sessionManager)
                .environment(pokemonManager)
                .environment(sessionManager)
                .environment(\.themeManager, themeManager)
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
