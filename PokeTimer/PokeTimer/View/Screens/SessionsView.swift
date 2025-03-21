//
//  SessionsView.swift
//  PokeTimer
//
//  Created by HUA Cindy on 24/02/2025.
//

import SwiftUI

// MARK: - SessionsView
/// A view that displays a list of saved focus sessions from our Pokémon.
struct SessionsView: View {
    @Environment(PokemonManager.self) var pokemonManager
    @Environment(SessionManager.self) var sessionManager
    @State private var viewModel: SessionsViewModel?

    var body: some View {
        VStack {
            if let viewModel = viewModel {
                List {
                    ForEach(viewModel.sessionsByPokemon, id: \.PokemonSpeciesLegacy) { pokemonData in
                        Section(header: Text(pokemonData.PokemonSpeciesLegacy.displayName).font(.headline)) {
                            ForEach(pokemonData.sessions) { session in
                                let formattedDurationString = TimeFormatterUtil.formattedDuration(session.duration)
                                VStack(alignment: .leading, spacing: 4) {
                                    Text("Duration: \(formattedDurationString) minutes")
                                        .font(.subheadline)
                                    Text("Started: \(DateFormatterUtil.formattedDate(session.startTime))")
                                        .font(.subheadline)
                                    Text("Ended: \(DateFormatterUtil.formattedDate(session.endTime))")
                                        .font(.subheadline)
                                    Text("Status: \(session.completed ? "Completed" : "Incomplete")")
                                        .font(.subheadline)
                                        .foregroundColor(session.completed ? .green : .red)
                                }
                                .padding(.vertical, 5)
                            }
                        }
                    }
                }
                .navigationTitle("Sessions")
            } else {
                Text("Loading sessions...")
                    .font(.headline)
            }
        }
        .onAppear {
            if viewModel == nil {
                viewModel = SessionsViewModel(
                    pokemonManager: pokemonManager,
                    sessionManager: sessionManager
                )
            }
        }
    }
}


#Preview {
    SessionsView()
    .environment(PreviewData.pokemonManager)
    .environment(PreviewData.sessionManager)
}
