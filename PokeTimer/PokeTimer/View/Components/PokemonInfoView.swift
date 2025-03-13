//
//  PokemonInfoView.swift
//  PokeTimer
//
//  Created by HUA Cindy on 13/03/2025.
//

import SwiftUI

struct PokemonInfoView: View {
    @Environment(PokemonManager.self) var pokemonManager

    var body: some View {
        if let currentPokemon = pokemonManager.getCurrentPokemon() {
            VStack(spacing: 10) {
                Text("Current Pokémon: \(currentPokemon.name)")
                    .font(.headline)

                Image(systemName: "bolt.fill") // Placeholder
                    .resizable()
                    .frame(width: 100, height: 100)
                    .foregroundColor(.yellow)

                HStack(spacing: 20) {
                    Text("XP: \(currentPokemon.xp)")
                    Text("Level: \(currentPokemon.level)")
                }
                .font(.headline)
            }
        }
    }
}

#Preview {
    PokemonInfoView()
        .environment(PreviewData.pokemonManager)
}

