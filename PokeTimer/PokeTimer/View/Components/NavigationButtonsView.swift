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
    var selectedDuration: Int

    var body: some View {
        VStack(spacing: 20) {
            NavigationLink(destination: TimerView(
                duration: TimeFormatterUtil.minutesToSeconds(selectedDuration),
                pokemonManager: pokemonManager,
                sessionManager: sessionManager
            )) {
                Text("Start")
                    .font(.title)
                    .frame(minWidth: 0, maxWidth: .infinity)
                    .padding()
                    .foregroundColor(.white)
                    .background(Color.green)
                    .cornerRadius(10)
            }
            .padding(.horizontal)

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
    NavigationButtonsView(selectedDuration: 25)
        .environment(PreviewData.pokemonManager)
        .environment(PreviewData.sessionManager)
}
