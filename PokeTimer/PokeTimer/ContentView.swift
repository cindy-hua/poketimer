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
    @State private var isRunning = false
    @State private var remainingSeconds: Int = 0
    @State private var timer: Timer? = nil
    @State private var showSessionSavedAlert = false
    
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
                
                // Time selection picker (only visible when timer is not running).
                if !isRunning {
                    Picker("Focus Duration", selection: $selectedDuration) {
                        ForEach(durationOptions, id: \.self) { minutes in
                            Text("\(minutes) minutes").tag(minutes)
                        }
                    }
                    .pickerStyle(WheelPickerStyle())
                    .frame(height: 100)
                }
                
                // Countdown Timer Display.
                Text(timeString(from: remainingSeconds))
                    .font(.system(size: 50, weight: .bold, design: .monospaced))
                    .animation(.easeInOut, value: remainingSeconds)
                
                // Start/Stop Button.
                Button(action: {
                    if isRunning {
                        stopTimer()
                    } else {
                        startTimer(duration: selectedDuration * 60)
                    }
                }) {
                    Text(isRunning ? "Stop" : "Start")
                        .font(.title)
                        .frame(minWidth: 0, maxWidth: .infinity)
                        .padding()
                        .foregroundColor(.white)
                        .background(isRunning ? Color.red : Color.green)
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
                        Text("View Pokemon")
                            .underline()
                            .foregroundColor(.blue)
                    }
                }
            }
            .padding()
            .navigationTitle("Focus Session")
            .alert(isPresented: $showSessionSavedAlert) {
                Alert(
                    title: Text("Session Completed"),
                    message: Text("Your focus session has been saved."),
                    dismissButton: .default(Text("OK"))
                )
            }
        }
    }
    
    // MARK: - Timer Functions
    func startTimer(duration: Int) {
        remainingSeconds = duration
        isRunning = true
        let startTime = Date()
        
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { timer in
            if remainingSeconds > 0 {
                remainingSeconds -= 1
            } else {
                timer.invalidate()
                isRunning = false
                let endTime = Date()
                let session = Session(duration: duration, startTime: startTime, endTime: endTime)
                // Log the session to the active Pokémon.
                manager.currentPokemon?.addSession(session)
                PersistenceManager.shared.save(manager: manager)
                showSessionSavedAlert = true
            }
        }
    }
    
    func stopTimer() {
        timer?.invalidate()
        timer = nil
        isRunning = false
    }
    
    func timeString(from seconds: Int) -> String {
        let minutes = seconds / 60
        let secs = seconds % 60
        return String(format: "%02d:%02d", minutes, secs)
    }
}

#Preview {
    ContentView().environmentObject(PokemonManager())
}
