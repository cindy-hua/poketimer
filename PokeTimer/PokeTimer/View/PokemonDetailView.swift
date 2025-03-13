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
    let pokemonID: UUID
    @Environment(PokemonManager.self) var pokemonManager
    @Environment(SessionManager.self) var sessionManager
    @State private var viewModel: PokemonDetailViewModel?

    var body: some View {
        VStack {
            if let viewModel = viewModel, let pokemon = viewModel.pokemon {
                // Basic Pokémon info
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

                // List of sessions (activities)
                List(viewModel.sessions) { session in
                    let formattedDurationString = TimeFormatterUtil.formattedDuration(session.duration)
                    VStack(alignment: .leading) {
                        Text("Duration: \(formattedDurationString) minutes")
                            .font(.headline)
                        Text("Started: \(DateFormatterUtil.formattedDate(session.startTime))")
                            .font(.subheadline)
                        Text("Ended: \(DateFormatterUtil.formattedDate(session.endTime))")
                            .font(.subheadline)
                    }
                    .padding(.vertical, 5)
                }
            } else {
                Text("Loading Pokémon details...")
                    .font(.headline)
            }
        }
        .navigationTitle(viewModel?.pokemonName ?? "Pokémon Details")
        .onAppear {
            if viewModel == nil {
                viewModel = PokemonDetailViewModel(
                    pokemonManager: pokemonManager,
                    sessionManager: sessionManager,
                    pokemonID: pokemonID
                )
            }
        }
    }
}


//#Preview {
//    // Create instances of managers
//    let pokemonManager = PokemonManager()
//    let sessionManager = SessionManager()
//
//    // Add a Pokémon to the manager
//    let testPokemon = Pokemon(name: "Pikachu", xp: 32)
//    pokemonManager.addPokemon(testPokemon)
//
//    // Retrieve the added Pokémon's ID
//    let testPokemonID = testPokemon.id
//
//    return PokemonDetailView(pokemonID: testPokemonID)
//        .environment(pokemonManager) // Provide managers
//        .environment(sessionManager)
//}

#Preview {
    PokemonDetailView(pokemonID: PreviewData.pokemonManager.pokemons[0].id)
    .environment(PreviewData.pokemonManager)
    .environment(PreviewData.sessionManager)
    .environment(PreviewData.themeManager)
}
