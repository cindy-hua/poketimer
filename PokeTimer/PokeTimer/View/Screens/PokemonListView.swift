//
//  PokemonListView.swift
//  PokeTimer
//
//  Created by HUA Cindy on 24/02/2025.
//

import SwiftUI

import SwiftUI

// MARK: - PokemonListView
/// A view that displays the Pokémon the user owns.
struct PokemonListView: View {
    @Environment(PokemonManager.self) var pokemonManager
    @State private var viewModel: PokemonListViewModel?

    var body: some View {
        NavigationStack {
            List {
                if let viewModel = viewModel {
                    ForEach(viewModel.ownedPokemon, id: \.id) { pokemon in
                        NavigationLink(destination: PokemonDetailView(pokemonID: pokemon.id)) {
                            HStack {
                                // Display the fetched Pokémon sprite
                                if let species = viewModel.pokemonDetails[pokemon.id] {
                                    AsyncImage(url: URL(string: species.spriteFront)) { image in
                                        image.resizable().scaledToFit()
                                    } placeholder: {
                                        ProgressView()
                                    }
                                    .frame(width: 50, height: 50)
                                } else {
                                    ProgressView().frame(width: 50, height: 50)
                                }

                                VStack(alignment: .leading) {
                                    Text(pokemon.species.rawValue.capitalized)
                                        .font(.headline)
                                    Text("XP: \(pokemon.xp)  Level: \(pokemon.level)")
                                        .font(.subheadline)
                                }
                            }
                        }
                    }
                }
            }
            .navigationTitle("My Pokémon")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Menu {
                        Button("Add Pikachu") { viewModel?.addPokemon(species: .pikachu) }
                        Button("Add Charmander") { viewModel?.addPokemon(species: .charmander) }
                        Button("Add Squirtle") { viewModel?.addPokemon(species: .squirtle) }
                    } label: {
                        Image(systemName: "plus")
                    }
                }
            }
            .onAppear {
                if viewModel == nil {
                    viewModel = PokemonListViewModel(pokemonManager: pokemonManager)
                }
                print("🐉 [DEBUG] PokemonListView appeared, updating UI")
            }
        }
    }
}

#Preview {
    PokemonListView()
        .environment(PreviewData.pokemonManager)
}
