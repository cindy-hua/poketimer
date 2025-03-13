//
//  PokemonPickerView.swift
//  PokeTimer
//
//  Created by HUA Cindy on 13/03/2025.
//

import SwiftUI

struct PokemonPickerView: View {
    @Environment(PokemonManager.self) var pokemonManager

    var body: some View {
        if pokemonManager.pokemons.isEmpty {
            Text("No Pokémon available. Please add a Pokémon!")
                .foregroundColor(.red)
        } else {
            Picker("Select Pokémon", selection: Binding(
                get: { pokemonManager.currentPokemonID ?? pokemonManager.pokemons.first?.id ?? UUID() },
                set: { pokemonManager.currentPokemonID = $0 }
            )) {
                ForEach(pokemonManager.pokemons) { pokemon in
                    Text(pokemon.name).tag(pokemon.id)
                }
            }
            .pickerStyle(MenuPickerStyle())
        }
    }
}

#Preview {
    PokemonPickerView()
        .environment(PreviewData.pokemonManager)
}
