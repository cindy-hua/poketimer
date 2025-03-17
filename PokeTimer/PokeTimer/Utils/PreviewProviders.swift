//
//  PreviewProviders.swift
//  PokeTimer
//
//  Created by HUA Cindy on 13/03/2025.
//

import Foundation
import SwiftUI

// MARK: - Preview Data Provider
struct PreviewData {
    // Pokémon Manager with sample Pokémon
    static let pokemonManager: PokemonManager = {
        let manager = PokemonManager()
        let pikachu = Pokemon(id: UUID(), species: .pikachu, xp: 120)
        let charmander = Pokemon(id: UUID(), species: .charmander, xp: 200)
        let bulbasaur = Pokemon(id: UUID(), species: .bulbasaur, xp: 50)

        manager.pokemons = [pikachu, charmander, bulbasaur]
        manager.currentPokemonID = pikachu.id // Set Pikachu as default
        return manager
    }()

    // Session Manager with mock sessions
    static let sessionManager: SessionManager = {
        let manager = SessionManager()
        let session1 = Session(duration: 25 * 60, startTime: Date().addingTimeInterval(-3600), endTime: Date().addingTimeInterval(-3300), completed: true, pokemonID: pokemonManager.pokemons[0].id)
        let session2 = Session(duration: 15 * 60, startTime: Date().addingTimeInterval(-1800), endTime: Date().addingTimeInterval(-900), completed: false, pokemonID: pokemonManager.pokemons[1].id)

        manager.restoreSessions(from: [session1, session2])
        return manager
    }()

    // Theme Manager
    static let themeManager = ThemeManager()
}
