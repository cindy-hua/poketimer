//
//  SessionsView.swift
//  PokeTimer
//
//  Created by HUA Cindy on 24/02/2025.
//

import SwiftUI

// MARK: - SessionsView
/// A view that displays a list of saved focus sessions from our Pokémon.
struct SessionsView: View {
    @EnvironmentObject var manager: PokemonManager
    
    var body: some View {
        List {
            ForEach(manager.pokemons) { pokemon in
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
        .navigationTitle("Sessions")
    }
    
    /// Helper function to format dates.
    func formattedDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.timeStyle = .short
        return formatter.string(from: date)
    }
}


#Preview {
    let manager = PokemonManager()
    return SessionsView().environmentObject(manager)
}
