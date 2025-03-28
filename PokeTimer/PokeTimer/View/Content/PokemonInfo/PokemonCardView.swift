//
//  PokemonCardView.swift
//  PokeTimer
//
//  Created by HUA Cindy on 19/03/2025.
//

import SwiftUI

struct PokemonCardView: View {
    @Environment(PokemonManager.self) var pokemonManager
    
    var body: some View {
        VStack(spacing: 8) {
            Text(pokemonManager.getCurrentPokemon()?.species.displayName ?? "Unknown")
                .font(.title2)
                .bold()
                .foregroundColor(.white)
                .shadow(color: .purple.opacity(0.3), radius: 2)

            HStack(spacing: 15) {
                HStack(spacing: 6) {
                    Image(systemName: "flame.fill") // 🔥 XP Icon
                        .foregroundColor(.white)
                        .foregroundColor(.orange).opacity(0.6)
                        .font(.system(size: 16, weight: .bold))
                    Text("\(pokemonManager.getCurrentPokemon()?.xp ?? 0)")
                        .font(.system(size: 12))
                        .bold()
                        .foregroundColor(.white)
                }
                .padding(.horizontal, 14)
                .padding(.vertical, 8)
                .background(
                    Capsule()
                        .fill(Color.orange.opacity(0.3)) // Custom glass effect
                        .overlay(Capsule().stroke(Color.orange.opacity(0.5), lineWidth: 1))
                        .shadow(color: Color.orange.opacity(0.6), radius: 3)
                )

                HStack(spacing: 6) {
                    Image(systemName: "star.fill") // ⭐ Level Icon
                        .foregroundColor(.white)
                        .foregroundColor(.yellow).opacity(0.6)
                        .font(.system(size: 16, weight: .bold))
                    Text("Lv \(pokemonManager.getCurrentPokemon()?.level ?? 1)")
                        .font(.system(size: 12))
                        .bold()
                        .foregroundColor(.white)
                }
                .padding(.horizontal, 14)
                .padding(.vertical, 8)
                .background(
                    Capsule()
                        .fill(Color.yellow.opacity(0.3)) // Custom glass effect
                        .overlay(Capsule().stroke(Color.yellow.opacity(0.5), lineWidth: 1))
                        .shadow(color: Color.yellow.opacity(0.6), radius: 3)
                )
            }
            .font(.headline)
        }
        .padding(12)
        .background(
            RoundedRectangle(cornerRadius: 15)
                .fill(Color.white.opacity(0.4))
                .overlay(
                    RoundedRectangle(cornerRadius: 15)
                        .stroke(Color.white.opacity(0.2), lineWidth: 1)
                )
                .shadow(color: Color.yellow.opacity(0.3), radius: 6)
        )
        .padding(.horizontal)

    }
}

#Preview {
    PokemonCardView().environment(PreviewData.pokemonManager)
}
