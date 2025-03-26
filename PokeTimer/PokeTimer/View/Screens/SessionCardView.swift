//
//  SessionCardView.swift
//  PokeTimer
//
//  Created by HUA Cindy on 26/03/2025.
//

import SwiftUI

struct SessionCardView: View {
    let session: Session
    let pokemon: Pokemon?
    let showPokemonImage: Bool

    var body: some View {
        HStack(spacing: 12) {
            // 🖼 Pokémon Image (Shown Only If `showPokemonImage` is True)
            if showPokemonImage, let pokemon = pokemon, !pokemon.species.spriteFront.isEmpty {
                AsyncImage(url: URL(string: pokemon.species.spriteFront)) { image in
                    image.resizable()
                        .scaledToFit()
                        .frame(width: 50, height: 50)
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                        .shadow(color: Color.black.opacity(0.1), radius: 2, x: 0, y: 1)
                } placeholder: {
                    ProgressView()
                        .frame(width: 50, height: 50)
                }
            }

            // 📜 Session Details
            VStack(alignment: .leading, spacing: 4) {
                Text("⏳ Duration: \(TimeFormatterUtil.formattedDuration(session.duration)) min")
                    .font(.headline)
                    .foregroundColor(.primary)

                Text("📅 Started: \(DateFormatterUtil.formattedDate(session.startTime))")
                    .font(.subheadline)
                    .foregroundColor(.secondary)

                Text("🏁 Ended: \(DateFormatterUtil.formattedDate(session.endTime))")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }

            Spacer()

            Image(systemName: "chevron.right")
                .foregroundColor(.gray)
        }
        .padding()
        .background(.ultraThinMaterial)
        .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
        .shadow(color: Color.black.opacity(0.05), radius: 3, x: 0, y: 2)
    }
}

#Preview {
    let sessionManager = PreviewData.sessionManager
    let session = sessionManager.sessions[0]
    return SessionCardView(session: session, pokemon: nil, showPokemonImage: false)
}
