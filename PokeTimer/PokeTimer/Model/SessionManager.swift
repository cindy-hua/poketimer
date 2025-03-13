//
//  SessionManager.swift
//  PokeTimer
//
//  Created by HUA Cindy on 10/03/2025.
//

import Foundation

// MARK: - Session Manager
/// Manages focus sessions separately from Pokémon.
@Observable
class SessionManager {
    private(set) var sessions: [Session] = []
    private let persistenceManager: PersistenceManager
    
    init(persistenceManager: PersistenceManager = .shared) {
        self.persistenceManager = persistenceManager
    }

    /// Adds a new session for a Pokémon.
    func addSession(_ session: Session) {
            sessions.append(session)
            persistenceManager.saveSessionManager(self)
        }

    /// Retrieves all sessions for a given Pokémon.
    func getSessions(for pokemonID: UUID) -> [Session] {
        return sessions.filter { $0.pokemonID == pokemonID }
    }
    
    /// Restores sessions from persistent storage.
    func restoreSessions(from savedSessions: [Session]) {
        self.sessions = savedSessions
    }
}
