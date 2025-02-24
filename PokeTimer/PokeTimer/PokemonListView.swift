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
                        }
                    }
                }
                .contextMenu {
                    Button(action: {
                        // Set this Pokémon as the active one.
                        manager.selectPokemon(pokemon)
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
                    // Create a new Pokémon (for demo purposes, auto-named).
                    let newPokemon = Pokemon(name: "New Pokémon \(manager.pokemons.count + 1)")
                    manager.addPokemon(newPokemon)
                }) {
                    Image(systemName: "plus")
                }
            }
        }
    }
}

#Preview {
    let manager = PokemonManager()
    return PokemonListView().environmentObject(manager)
}
