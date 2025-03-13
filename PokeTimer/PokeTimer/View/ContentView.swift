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
            VStack(spacing: 40) {
                // Apply theme colors
                themeManager.currentTheme.background
                    .edgesIgnoringSafeArea(.all)
                
                // Picker to choose a Pokémon.
                if pokemonManager.pokemons.isEmpty {
                    Text("No Pokémon available. Please add a Pokémon!")
                        .foregroundColor(.red)
                } else {
                    Picker("Select Pokémon", selection: Binding(
                        get: { pokemonManager.currentPokemonID ?? pokemonManager.pokemons.first?.id ?? UUID() },
                        set: { pokemonManager.currentPokemonID = $0 }
                    )) {
                        ForEach(pokemonManager.pokemons) { pokemon in
                            Text(pokemon.name).tag(pokemon.id)
                        }
                    }
                    .pickerStyle(MenuPickerStyle())
                }
                
                // Show Current Active Pokémon's Name
                if let currentPokemon = pokemonManager.getCurrentPokemon() {
                    Text("Current Pokémon: \(currentPokemon.name)")
                        .font(.headline)
                }
                
                // Pokémon Display (placeholder image).
                Image(systemName: "bolt.fill")
                    .resizable()
                    .frame(width: 100, height: 100)
                    .foregroundColor(.yellow)
                
                // Display XP & Level from the active Pokémon.
                if let currentPokemon = pokemonManager.getCurrentPokemon() {
                    HStack(spacing: 20) {
                        Text("XP: \(currentPokemon.xp)")
                        Text("Level: \(currentPokemon.level)")
                    }
                    .font(.headline)
                }
                
                // Time selection picker.
                Picker("Focus Duration", selection: $viewModel.selectedDuration) {
                    ForEach(viewModel.durationOptions, id: \.self) { minutes in
                        Text("\(minutes) minutes").tag(minutes)
                    }
                }
                .pickerStyle(WheelPickerStyle())
                .frame(height: 100)
                
                // Navigation Link to the TimerView.
                NavigationLink(destination: TimerView(
                    duration: TimeFormatterUtil.minutesToSeconds(viewModel.selectedDuration),
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
                
                // Navigation links for additional views.
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
            .padding()
            .navigationTitle("Focus Session")
            .onAppear {
                if viewModel.pokemonManager !== pokemonManager || viewModel.sessionManager !== sessionManager {
                    viewModel = ContentViewModel(pokemonManager: pokemonManager, sessionManager: sessionManager)
                }
                print("🎯 [DEBUG] PokemonManager in ContentView: \(Unmanaged.passUnretained(pokemonManager).toOpaque())")
            }
        }
    }
}

#Preview {
    let pokemonManager = PokemonManager()
    let sessionManager = SessionManager()
    let themeManager = ThemeManager()
    let persistenceManager: PersistenceManager = .shared
    return ContentView(pokemonManager: pokemonManager, sessionManager: sessionManager, persistenceManager: persistenceManager)
        .environment(pokemonManager)
        .environment(sessionManager)
        .environment(themeManager)
}
