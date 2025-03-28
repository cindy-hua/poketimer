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
        ZStack {
            GlassBackgroundOverlay()
            
            ScrollView {
                VStack(spacing: 16) {
                    if let viewModel = viewModel, let pokemon = viewModel.pokemon {
                        
                        // 🖼 Pokémon Image
                        if let species = viewModel.pokemonSpecies {
                            AsyncImage(url: URL(string: species.spriteFront)) { image in
                                image.resizable()
                                    .scaledToFit()
                                    .frame(width: 150, height: 150)
                                    .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
                                    .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 2)
                            } placeholder: {
                                ProgressView()
                                    .frame(width: 100, height: 100)
                            }
                        }

                        // 🏆 Pokémon Name + XP + Level
                        VStack(spacing: 4) {
                            Text(pokemon.species.name.capitalized)
                                .font(.system(size: 28, weight: .bold, design: .rounded))
                                .foregroundStyle(
                                    LinearGradient(
                                        gradient: Gradient(colors: [Color.orange.opacity(0.8), Color.purple.opacity(0.8)]),
                                        startPoint: .topLeading,
                                        endPoint: .bottomTrailing
                                    )
                                )
                                .shadow(color: Color.white.opacity(0.3), radius: 1)

                            HStack(spacing: 10) {
                                Label("\(pokemon.xp)", systemImage: "flame.fill")
                                    .foregroundStyle(Color.orange)
                                    .font(.headline)

                                Label("Lv \(pokemon.level)", systemImage: "star.fill")
                                    .foregroundStyle(Color.yellow)
                                    .font(.headline)
                            }
                        }
                        .padding(.top, 8)

                        // 🏷 Type Badges
                        if let species = viewModel.pokemonSpecies {
                            HStack(spacing: 8) {
                                ForEach(species.types, id: \.self) { type in
                                    Text(type.capitalized)
                                        .font(.subheadline)
                                        .padding(.vertical, 6)
                                        .padding(.horizontal, 12)
                                        .background(PokemonTypeColor.color(for: type).opacity(0.8))
                                        .foregroundColor(.white)
                                        .clipShape(Capsule())
                                        .shadow(color: Color.black.opacity(0.1), radius: 2)
                                }
                            }
                            .padding(.top, 6)
                        }

                        // 📜 List of Sessions (Activities)
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Focus Sessions")
                                .font(.title2)
                                .bold()
                                .padding(.bottom, 5)

                            if viewModel.sessions.isEmpty {
                                Text("No sessions recorded yet.")
                                    .font(.subheadline)
                                    .foregroundColor(.gray)
                            } else {
                                ForEach(viewModel.sessions) { session in
                                    SessionCardView(session: session, pokemon: nil, showPokemonImage: false)
                                }
                            }
                        }
                        .padding()
                        .background(.ultraThinMaterial)
                        .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
                        .shadow(color: Color.black.opacity(0.05), radius: 3, x: 0, y: 2)
                        .padding(.top, 8)
                    } else {
                        Text("Loading Pokémon details...")
                            .font(.headline)
                            .foregroundColor(.gray)
                    }
                }
                .padding()
            }
            .navigationTitle(viewModel?.pokemonSpecies?.displayName ?? "Pokémon Details")
            .navigationBarTitleDisplayMode(.inline)
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
}

#Preview {
    PokemonDetailView(pokemonID: PreviewData.pokemonManager.pokemons[0].id)
    .environment(PreviewData.pokemonManager)
    .environment(PreviewData.sessionManager)
}
