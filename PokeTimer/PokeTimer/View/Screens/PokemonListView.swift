//
//  PokemonListView.swift
//  PokeTimer
//
//  Created by HUA Cindy on 24/02/2025.
//

import SwiftUI

// MARK: - PokemonListView
/// A view that displays the Pokémon the user owns.
struct PokemonListView: View {
    @Environment(PokemonManager.self) var pokemonManager
    @State private var viewModel: PokemonListViewModel?

    var body: some View {
        NavigationStack {
            ZStack {
                GlassBackgroundOverlay()
                ScrollView {
                    if let viewModel = viewModel {
                        LazyVStack(spacing: 10) {
                            ForEach(viewModel.ownedPokemon, id: \.id) { pokemon in
                                NavigationLink(destination: PokemonDetailView(pokemonID: pokemon.id)) {
                                    PokemonRowView(
                                        pokemon: pokemon,
                                        species: viewModel.pokemonDetails[pokemon.id]
                                    )
                                }
                            }
                        }
                        .padding()
                    }
                }
                .navigationTitle("My Pokemon")
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Menu {
                            Button("Add Pikachu") {
                                viewModel?.addPokemon(species: PokemonSpecies(
                                    id: 25, name: "Pikachu", types: ["Electric"],
                                    spriteFront: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/25.png",
                                    spriteBack: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/back/25.png",
                                    spriteShiny: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/shiny/25.png",
                                    dreamWorld: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/dream-world/25.svg",
                                    officialArtwork: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/25.png",
                                    showdown: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/showdown/25.gif",
                                    home: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/home/25.png",
                                    evolutionChain: ["Pichu", "Pikachu", "Raichu"]
                                ))
                            }
                            Button("Add Charmander") {
                                viewModel?.addPokemon(species: PokemonSpecies(
                                    id: 4,
                                    name: "Charmander",
                                    types: ["Fire"],
                                    spriteFront: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/4.png",
                                    spriteBack: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/back/4.png",
                                    spriteShiny: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/shiny/4.png",
                                    dreamWorld: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/dream-world/4.svg",
                                    officialArtwork: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/4.png",
                                    showdown: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/showdown/4.gif",
                                    home: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/home/4.png",
                                    evolutionChain: ["Charmander", "Charmeleon", "Charizard"]
                                ))
                            }
                            Button("Add Squirtle") {
                                viewModel?.addPokemon(species: PokemonSpecies(
                                    id: 7,
                                    name: "Squirtle",
                                    types: ["Water"],
                                    spriteFront: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/7.png",
                                    spriteBack: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/back/7.png",
                                    spriteShiny: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/shiny/7.png",
                                    dreamWorld: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/dream-world/7.svg",
                                    officialArtwork: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/7.png",
                                    showdown: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/showdown/7.gif",
                                    home: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/home/7.png",
                                    evolutionChain: ["Squirtle", "Wartortle", "Blastoise"]
                                ))
                            }
                        } label: {
                            Image(systemName: "plus")
                        }
                    }
                }
            }
            .onAppear {
                if viewModel == nil {
                    viewModel = PokemonListViewModel(pokemonManager: pokemonManager)
                }
            }
        }
    }
}

#Preview {
    PokemonListView()
        .environment(PreviewData.pokemonManager)
}
