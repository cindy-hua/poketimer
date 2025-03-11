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
    @Environment(PokemonManager.self) var pokemonManager
    @Environment(SessionManager.self) var sessionManager
    @State private var viewModel: SessionsViewModel?

    var body: some View {
        VStack {
            if let viewModel = viewModel {
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
            } else {
                Text("Loading sessions...")
                    .font(.headline)
            }
        }
        .onAppear {
            if viewModel == nil {
                viewModel = SessionsViewModel(
                    pokemonManager: pokemonManager,
                    sessionManager: sessionManager
                )
            }
        }
    }
}


#Preview {
    // Create instances of managers
    let pokemonManager = PokemonManager()
    let sessionManager = SessionManager()

    // Add a Pokémon to the manager
    let testPokemon = Pokemon(name: "Pikachu", xp: 32)
    pokemonManager.addPokemon(testPokemon)

    // Retrieve the added Pokémon's ID
    let testPokemonID = testPokemon.id

    return PokemonDetailView(pokemonID: testPokemonID)
        .environment(pokemonManager)
        .environment(sessionManager)
}
