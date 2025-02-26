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
    @StateObject private var viewModel: SessionsViewModel

    init(manager: PokemonManager) {
        _viewModel = StateObject(wrappedValue: SessionsViewModel(manager: manager))
    }

    var body: some View {
        List {
            ForEach(viewModel.sessionsByPokemon, id: \.pokemonName) { pokemonData in
                Section(header: Text(pokemonData.pokemonName).font(.headline)) {
                    ForEach(pokemonData.sessions) { session in
                        VStack(alignment: .leading, spacing: 4) {
                            Text("Duration: \(session.duration / 60) minutes")
                                .font(.subheadline)
                            Text("Started: \(viewModel.formattedDate(session.startTime))")
                                .font(.subheadline)
                            Text("Ended: \(viewModel.formattedDate(session.endTime))")
                                .font(.subheadline)
                            Text("Status: \(session.completed ? "Completed" : "Incomplete")")
                                .font(.subheadline)
                                .foregroundColor(session.completed ? .green : .red)
                        }
                        .padding(.vertical, 5)
                    }
                }
            }
        }
        .navigationTitle("Sessions")
        .onAppear {
            viewModel.loadSessions()
        }
    }
}


#Preview {
    let manager = PokemonManager()
    return SessionsView(manager: manager).environmentObject(manager)
}
