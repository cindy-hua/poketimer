//
//  PokemonListView.swift
//  PokeTimer
//
//  Created by HUA Cindy on 24/02/2025.
//

import SwiftUI

// MARK: - PokemonListView
/// A view that displays a list of Pokémon and allows you to add new ones or set an active Pokémon.
struct PokemonListView: View {
    @Environment(PokemonManager.self) var pokemonManager
    @State private var viewModel: PokemonListViewModel?
    
    var body: some View {
        List {
            ForEach(pokemonManager.pokemons, id: \.id) { pokemon in
                NavigationLink(destination: PokemonDetailView(pokemonID: pokemon.id)) {
                    HStack {
                        // Placeholder image.
                        Image(systemName: "bolt.fill")
                            .resizable()
                            .frame(width: 40, height: 40)
                            .foregroundColor(.yellow)
                        VStack(alignment: .leading) {
                            Text(pokemon.name)
                                .font(.headline)
                            Text("XP: \(pokemon.xp)  Level: \(pokemon.level)")
                                .font(.subheadline)
                        }
                    }
                }
            }
        }
        .navigationTitle("Pokémon List")
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: {
                    viewModel?.addPokemon()
                }) {
                    Image(systemName: "plus")
                }
            }
        }
        .onAppear {
            if viewModel == nil { // ✅ Only initialize once
                viewModel = PokemonListViewModel(pokemonManager: pokemonManager)
            }
            print("🐉 [DEBUG] PokemonListView appeared, updating UI")
        }
        .onChange(of: pokemonManager.pokemons) {
            print("🔄 [DEBUG] manager.pokemons changed! UI should refresh.")
        }
    }
}

#Preview {
    PokemonListView()
        .environment(PreviewData.pokemonManager)
}
