//
//  PokemonDetailView.swift
//  PokeTimer
//
//  Created by HUA Cindy on 24/02/2025.
//

import SwiftUI

// MARK: - PokemonDetailView
/// A view to display details and activities for a specific Pokémon.
struct PokemonDetailView: View {
    @StateObject private var viewModel: PokemonDetailViewModel

    init(pokemon: Pokemon) {
        _viewModel = StateObject(wrappedValue: PokemonDetailViewModel(pokemon: pokemon))
    }

    var body: some View {
        VStack {
            // Basic Pokémon info.
            HStack(spacing: 20) {
                Image(systemName: "bolt.fill")
                    .resizable()
                    .frame(width: 80, height: 80)
                    .foregroundColor(.yellow)
                VStack(alignment: .leading) {
                    Text(viewModel.pokemonName)
                        .font(.largeTitle)
                    Text("XP: \(viewModel.xp)")
                    Text("Level: \(viewModel.level)")
                }
            }
            .padding()
            
            // List of sessions (activities).
            List {
                ForEach(viewModel.sessions) { session in
                    VStack(alignment: .leading) {
                        Text("Duration: \(session.duration / 60) minutes")
                            .font(.headline)
                        Text("Started: \(viewModel.formattedDate(session.startTime))")
                            .font(.subheadline)
                        Text("Ended: \(viewModel.formattedDate(session.endTime))")
                            .font(.subheadline)
                    }
                    .padding(.vertical, 5)
                }
            }
        }
        .navigationTitle("\(viewModel.pokemonName)'s Activities")
        .onAppear {
            viewModel.refreshData() // Ensure latest data is shown
        }
    }
}


#Preview {
    let pokemon = Pokemon(name: "starter")
    return PokemonDetailView(pokemon: pokemon)
}
