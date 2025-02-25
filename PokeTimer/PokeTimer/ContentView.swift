//
//  ContentView.swift
//  PokeTimer
//
//  Created by HUA Cindy on 24/02/2025.
//

import SwiftUI

// MARK: - ContentView (Focus Session View)
struct ContentView: View {
    @EnvironmentObject var manager: PokemonManager
    
    // Timer-related states.
    @State private var selectedDuration = 5 // in minutes.
    
    // Duration options from 5 to 120 minutes (in steps of 5).
    let durationOptions = Array(stride(from: 5, through: 120, by: 5))
    
    var body: some View {
        NavigationView {
            VStack(spacing: 40) {
                // Picker to choose a Pokémon.
                Picker("Select Pokémon", selection: Binding(
                    get: { manager.currentPokemon ?? manager.pokemons.first! },
                    set: { manager.currentPokemon = $0 }
                )) {
                    ForEach(manager.pokemons) { pokemon in
                        Text(pokemon.name)
                            .tag(pokemon)
                    }
                }
                .pickerStyle(MenuPickerStyle())
                
                // Show the current active Pokémon's name.
                if let currentPokemon = manager.currentPokemon {
                    Text("Current Pokémon: \(currentPokemon.name)")
                        .font(.headline)
                }
                
                // Pokémon Display (placeholder image).
                Image(systemName: "bolt.fill")
                    .resizable()
                    .frame(width: 100, height: 100)
                    .foregroundColor(.yellow)
                
                // Display XP & Level from the active Pokémon.
                if let currentPokemon = manager.currentPokemon {
                    HStack(spacing: 20) {
                        Text("XP: \(currentPokemon.xp)")
                        Text("Level: \(currentPokemon.level)")
                    }
                    .font(.headline)
                }
                
                // Time selection picker.
                Picker("Focus Duration", selection: $selectedDuration) {
                    ForEach(durationOptions, id: \.self) { minutes in
                        Text("\(minutes) minutes").tag(minutes)
                    }
                }
                .pickerStyle(WheelPickerStyle())
                .frame(height: 100)
                
                // Navigation Link to the TimerView.
                NavigationLink(destination: TimerView(duration: selectedDuration * 60)) {
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
                    NavigationLink(destination: SessionsView()) {
                        Text("View Sessions")
                            .underline()
                            .foregroundColor(.blue)
                    }
                    NavigationLink(destination: PokemonListView()) {
                        Text("View Pokémon")
                            .underline()
                            .foregroundColor(.blue)
                    }
                }
            }
            .padding()
            .navigationTitle("Focus Session")
        }
    }
}

#Preview {
    ContentView().environmentObject(PokemonManager())
}
