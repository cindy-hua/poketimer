//
//  PokeballView.swift
//  PokeTimer
//
//  Created by HUA Cindy on 13/03/2025.
//

import SwiftUI

struct PokeballView: View {
    @Environment(PokemonManager.self) var pokemonManager
    var size: CGFloat = 250
    @Binding var rotationAngle: Double

    var body: some View {
        ZStack {
            BottomPokeballView(size: size)
                .rotationEffect(.degrees(rotationAngle))

            // Pokémon (Inside Pokéball)
            if let spriteURL = pokemonManager.getCurrentPokemon()?.species.home {
                AsyncImage(url: URL(string: spriteURL)) { image in
                    image.resizable()
                        .frame(width: size * 0.85, height: size * 0.85)
                } placeholder: {
                    ProgressView()  // Shows a loading spinner while fetching the image
                }
                .frame(width: size * 1.3, height: size * 1.3)
                .clipShape(Circle())
                .opacity(0.75)
            } else {
                Image("unknown")
                    .resizable()
                    .scaledToFit()
                    .frame(width: size * 1.3, height: size * 1.3)
                    .clipShape(Circle())
                    .opacity(0.95)
            }

            TopPokeballView(size: size)
                .rotationEffect(.degrees(rotationAngle))

        }
        .frame(width: size, height: size)
        .clipShape(Circle())
        .shadow(color: Color.purple.opacity(0.3), radius: 15)
    }
}

#Preview {
    PokeballView(rotationAngle: .constant(0)).environment(PreviewData.pokemonManager)
}
