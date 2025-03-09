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
    @EnvironmentObject var manager: PokemonManager
    @StateObject private var viewModel: PokemonListViewModel
    
    init(manager: PokemonManager) {
        _viewModel = StateObject(wrappedValue: PokemonListViewModel(manager: manager))
    }
    
    var body: some View {
        List {
            ForEach(manager.pokemons) { pokemon in
                NavigationLink(destination: PokemonDetailView(pokemon: pokemon)) {
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
                            Text("Sessions: \(pokemon.sessions.count)")
                                .font(.subheadline)
                        }
                    }
                }
                .contextMenu {
                    Button(action: {
                        viewModel.selectPokemon(pokemon)
                    }) {
                        Text("Set as Active")
                        Image(systemName: "star")
                    }
                }
            }
        }
        .navigationTitle("Pokémon List")
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: {
                    viewModel.addPokemon()
                }) {
                    Image(systemName: "plus")
                }
            }
        }
        .onAppear {
            viewModel.updateData()
            print("🐉 [DEBUG] PokemonListView appeared, updating UI")
        }
        .onChange(of: manager.pokemons) { _ in
            print("🔄 [DEBUG] manager.pokemons changed! UI should refresh.")
        }
    }
}

#Preview {
    let manager = PokemonManager()
    return PokemonListView(manager: manager).environmentObject(manager)
}
