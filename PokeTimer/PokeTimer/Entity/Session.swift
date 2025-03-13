//
//  Session.swift
//  PokeTimer
//
//  Created by HUA Cindy on 24/02/2025.
//

import Foundation

// A simple model for a focus session.
struct Session: Identifiable, Codable, Equatable {
    var id = UUID()
    let duration: Int       // Duration in seconds.
    let startTime: Date
    let endTime: Date
    let completed: Bool
    let pokemonID: UUID
    
    var durationInMinutes: Int {
        return duration / 60
    }
}
