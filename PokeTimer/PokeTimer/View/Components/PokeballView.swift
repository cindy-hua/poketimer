//
//  PokeballView.swift
//  PokeTimer
//
//  Created by HUA Cindy on 13/03/2025.
//

import SwiftUI

struct PokeballView: View {
    @Environment(PokemonManager.self) var pokemonManager
    var size: CGFloat = 250 // Customizable size
    @State private var glowOpacity: Double = 0.6

    var body: some View {
        ZStack {
            BottomPokeballView(size: size)

            // Pokémon (Inside Pokéball)
            Image(pokemonManager.getCurrentPokemon()?.species.imageName ?? "pikachu")
                .resizable()
                .scaledToFit()
                .frame(width: size * 1.3, height: size * 1.3)
                .clipShape(Circle())
                .opacity(0.95)
                .blur(radius: 1.1)

            TopPokeballView(size: size)

        }
        .frame(width: size, height: size)
        .clipShape(Circle())
        .shadow(color: Color.purple.opacity(0.3), radius: 15)
    }
}




#Preview {
    PokeballView().environment(PreviewData.pokemonManager)
}
