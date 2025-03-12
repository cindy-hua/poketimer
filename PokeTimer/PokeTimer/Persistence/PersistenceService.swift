//
//  PersistenceService.swift
//  PokeTimer
//
//  Created by HUA Cindy on 12/03/2025.
//

import Foundation

protocol PersistenceService {
    func savePokemonManager(_ manager: PokemonManager)
    func saveSessionManager(_ manager: SessionManager)
    func loadPokemonManager() -> PokemonManager
    func loadSessionManager() -> SessionManager
}

extension CodingUserInfoKey {
    static let persistenceService = CodingUserInfoKey(rawValue: "persistenceService")!
}
