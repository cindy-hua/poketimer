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
        HStack(spacing: 40) {    
            NavigationLink(destination: SessionsView()
                .environment(pokemonManager)
                .environment(sessionManager)) {
                    GlassButtonView(imageName: "calendar_icon"){}
            }
            
            NavigationLink(destination: PokemonListView()
                .environment(pokemonManager)) {
                    GlassButtonView(imageName: "pokemon_icon"){}
            }
        }
        .padding(.top, 10)
    }
}

#Preview {
    NavigationButtonsView()
        .environment(PreviewData.pokemonManager)
        .environment(PreviewData.sessionManager)
}
