//
//  PokemonDetailView.swift
//  PokeTimer
//
//  Created by HUA Cindy on 24/02/2025.
//

import SwiftUI

// MARK: - PokemonDetailView
/// A view to display details and activities for a specific Pokémon.
struct PokemonDetailView: View {
    @ObservedObject var pokemon: Pokemon
    
    var body: some View {
        VStack {
            // Basic Pokémon info.
            HStack(spacing: 20) {
                Image(systemName: "bolt.fill")
                    .resizable()
                    .frame(width: 80, height: 80)
                    .foregroundColor(.yellow)
                VStack(alignment: .leading) {
                    Text(pokemon.name)
                        .font(.largeTitle)
                    Text("XP: \(pokemon.xp)")
                    Text("Level: \(pokemon.level)")
                }
            }
            .padding()
            
            // List of sessions (activities).
            List {
                ForEach(pokemon.sessions) { session in
                    VStack(alignment: .leading) {
                        Text("Duration: \(session.duration / 60) minutes")
                            .font(.headline)
                        Text("Started: \(formattedDate(session.startTime))")
                            .font(.subheadline)
                        Text("Ended: \(formattedDate(session.endTime))")
                            .font(.subheadline)
                    }
                    .padding(.vertical, 5)
                }
            }
        }
        .navigationTitle("\(pokemon.name)'s Activities")
    }
    
    /// Formats a date into a readable string.
    func formattedDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.timeStyle = .short
        return formatter.string(from: date)
    }
}

#Preview {
    let pokemon = Pokemon(name: "starter")
    return PokemonDetailView(pokemon: pokemon)
}
