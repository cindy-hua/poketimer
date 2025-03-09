//
//  Pokemon.swift
//  PokeTimer
//
//  Created by HUA Cindy on 24/02/2025.
//

import Foundation

import SwiftUI

// MARK: - Pokemon Class
/// A class representing a Pokémon that logs focus sessions, tracks XP (in minutes), and computes its level.
class Pokemon: ObservableObject, Identifiable, Codable, Equatable, Hashable {
    var id = UUID()
    var name: String
    @Published var xp: Int         // Total XP (in minutes)
    @Published var level: Int
    @Published var sessions: [Session]
    
    // Coding keys for Codable conformance.
    enum CodingKeys: CodingKey {
        case id, name, xp, level, sessions
    }
    
    init(name: String) {
        self.name = name
        self.xp = 0
        self.level = 1
        self.sessions = []
    }
    
    /// Adds a new session, updates XP and recalculates the level.
    /// - Parameter session: A completed focus session.
    func addSession(_ session: Session) {
        sessions.append(session)
        // Convert session duration (seconds) to minutes.
        xp += session.duration / 60
        recalcLevel()
        objectWillChange.send()
    }
    
    /// Recalculates the level based on XP.
    /// For example, every 16 minutes gives a level increase.
    private func recalcLevel() {
        level = 1 + xp / 16
    }
    
    // MARK: - Codable Conformance
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(UUID.self, forKey: .id)
        name = try container.decode(String.self, forKey: .name)
        xp = try container.decode(Int.self, forKey: .xp)
        level = try container.decode(Int.self, forKey: .level)
        sessions = try container.decode([Session].self, forKey: .sessions)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(name, forKey: .name)
        try container.encode(xp, forKey: .xp)
        try container.encode(level, forKey: .level)
        try container.encode(sessions, forKey: .sessions)
    }
    
    // MARK: - Equatable & Hashable
    static func == (lhs: Pokemon, rhs: Pokemon) -> Bool {
        return lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

