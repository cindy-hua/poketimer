//
//  PokemonRowView.swift
//  PokeTimer
//
//  Created by HUA Cindy on 25/03/2025.
//

import SwiftUI

struct PokemonRowView: View {
    let pokemon: Pokemon
    let species: PokemonSpecies?

    var body: some View {
        HStack(spacing: 12) {
            // Pokémon Image
            AsyncImage(url: URL(string: species?.spriteFront ?? "")) { image in
                image.resizable()
                    .scaledToFit()
                    .frame(width: 60, height: 60)
                    .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
                    .shadow(color: Color.black.opacity(0.1), radius: 3, x: 0, y: 2)
            } placeholder: {
                ProgressView()
                    .frame(width: 50, height: 50)
            }

            // Pokémon Info
            VStack(alignment: .leading, spacing: 2) {
                Text(pokemon.species.name.capitalized)
                    .font(.system(.title3, design: .rounded))
                    .fontWeight(.semibold)
                    .foregroundColor(.primary)

                HStack(spacing: 6) {
                    Label("\(pokemon.xp)", systemImage: "flame.fill")
                        .foregroundStyle(Color.orange)
                        .font(.caption)

                    Label("Lv \(pokemon.level)", systemImage: "star.fill")
                        .foregroundStyle(Color.yellow)
                        .font(.caption)
                }
            }

            Spacer()

            Image(systemName: "chevron.right")
                .foregroundColor(.secondary)
        }
        .padding(12)
        .background(.ultraThinMaterial)
        .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
        .shadow(color: Color.black.opacity(0.05), radius: 2, x: 0, y: 1)
    }
}


//#Preview {
//    let pokemon = PreviewData.pokemonManager.pokemons[0]
//    return PokemonRowView(
//        pokemon: pokemon,
//        species: pokemon.species
//    )
//}
