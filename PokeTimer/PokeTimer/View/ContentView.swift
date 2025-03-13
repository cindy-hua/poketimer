//
//  ContentView.swift
//  PokeTimer
//
//  Created by HUA Cindy on 24/02/2025.
//

import SwiftUI

// MARK: - ContentView (Focus Session View)
struct ContentView: View {
    @Environment(PokemonManager.self) var pokemonManager
    @Environment(SessionManager.self) var sessionManager
    @Environment(\.themeManager) var themeManager

    @State private var viewModel: ContentViewModel

    init(pokemonManager: PokemonManager, sessionManager: SessionManager, persistenceManager: PersistenceManager = .shared) {
        _viewModel = State(initialValue: ContentViewModel(
            pokemonManager: pokemonManager,
            sessionManager: sessionManager,
            persistenceManager: persistenceManager
        ))
    }

    var body: some View {
        NavigationStack {
            ZStack {
                // Apply theme colors
                themeManager.currentTheme.background
                    .edgesIgnoringSafeArea(.all)

                VStack(spacing: 40) {
                    PokemonPickerView() // Modular Pokémon Picker
                    PokemonInfoView() // Modular Pokémon Info
                    FocusDurationPickerView(selectedDuration: $viewModel.selectedDuration, durationOptions: viewModel.durationOptions) // Modular Picker
                    NavigationButtonsView(selectedDuration: viewModel.selectedDuration) // Modular Navigation Buttons
                }
            }
        }
        .navigationTitle("Focus Session")
        .onAppear {
            if viewModel.pokemonManager !== pokemonManager || viewModel.sessionManager !== sessionManager {
                viewModel = ContentViewModel(pokemonManager: pokemonManager, sessionManager: sessionManager)
            }
            print("🎯 [DEBUG] PokemonManager in ContentView: \(Unmanaged.passUnretained(pokemonManager).toOpaque())")
        }
    }
}

#Preview {
    ContentView(
        pokemonManager: PreviewData.pokemonManager,
        sessionManager: PreviewData.sessionManager,
        persistenceManager: .shared
    )
    .environment(PreviewData.pokemonManager)
    .environment(PreviewData.sessionManager)
    .environment(PreviewData.themeManager)
}
