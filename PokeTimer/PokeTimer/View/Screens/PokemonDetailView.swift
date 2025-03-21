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
                    if let species = viewModel.pokemonSpecies {
                        AsyncImage(url: URL(string: species.spriteFront)) { image in
                            image.resizable().scaledToFit()
                        } placeholder: {
                            ProgressView()
                        }
                        .frame(width: 100, height: 100)
                    } else {
                        ProgressView().frame(width: 100, height: 100)
                    }

                    VStack(alignment: .leading) {
                        Text(pokemon.species.rawValue.capitalized)
                            .font(.largeTitle)
                        Text("XP: \(pokemon.xp)")
                        Text("Level: \(pokemon.level)")
                    }
                }
                .padding()
                
                // Pokémon Type Badges
                if let species = viewModel.pokemonSpecies {
                    HStack {
                        ForEach(species.types, id: \.self) { type in
                            Text(type)
                                .padding(5)
                                .background(Color.blue.opacity(0.3))
                                .clipShape(Capsule())
                        }
                    }
                }

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
        .navigationTitle(viewModel?.pokemonSpecies?.displayName ?? "Pokémon Details")
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

#Preview {
    PokemonDetailView(pokemonID: PreviewData.pokemonManager.pokemons[0].id)
    .environment(PreviewData.pokemonManager)
    .environment(PreviewData.sessionManager)
}
