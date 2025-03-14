//
//  NavigationButtonsView.swift
//  PokeTimer
//
//  Created by HUA Cindy on 13/03/2025.
//

import SwiftUI

struct NavigationButtonsView: View {
    @Environment(PokemonManager.self) var pokemonManager
    @Environment(SessionManager.self) var sessionManager

    var body: some View {
        VStack(spacing: 20) {
            HStack(spacing: 20) {
                NavigationLink(destination: SessionsView()
                    .environment(pokemonManager)
                    .environment(sessionManager)) {
                        Text("View Sessions")
                            .underline()
                            .foregroundColor(.blue)
                    }

                NavigationLink(destination: PokemonListView()
                    .environment(pokemonManager)) {
                        Text("View Pokémon")
                            .underline()
                            .foregroundColor(.blue)
                    }
            }
        }
    }
}

#Preview {
    NavigationButtonsView()
        .environment(PreviewData.pokemonManager)
        .environment(PreviewData.sessionManager)
}
