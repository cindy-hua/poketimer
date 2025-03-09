//
//  TimerViewModel.swift
//  PokeTimer
//
//  Created by HUA Cindy on 25/02/2025.
//

import Foundation

class TimerViewModel: ObservableObject {
    // Timer-related states.
    @Published var remainingSeconds: Int
    @Published var isRunning = false
    @Published var isSessionCompleted = false
    
    private var timer: Timer?
    private var startTime: Date?
    let duration: Int
    
    private let manager: PokemonManager
    
    init(duration: Int, manager: PokemonManager) {
        self.duration = duration
        self.remainingSeconds = duration
        self.manager = manager
    }
    
    /// Starts the timer.
    func startTimer() {
        startTime = Date()
        isRunning = true
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { [weak self] t in
            guard let self = self else { return }
            if self.remainingSeconds > 0 {
                self.remainingSeconds -= 1
            } else {
                t.invalidate()
                self.isRunning = false
                self.isSessionCompleted = true
                self.saveSession(completed: true)
            }
        }
    }
    
    /// Stops the timer early and saves an incomplete session.
    func stopTimer() {
        timer?.invalidate()
        timer = nil
        isRunning = false
        saveSession(completed: false)
    }

    /// Saves the session, associating it with the current Pokémon.
    private func saveSession(completed: Bool) {
        let endTime = Date()
        let elapsedTime = completed ? duration : Int(endTime.timeIntervalSince(startTime ?? endTime))
        
        let session = Session(
            duration: elapsedTime,
            startTime: startTime ?? endTime,
            endTime: endTime,
            completed: completed,
            pokemonID: manager.currentPokemon?.id ?? UUID()
        )

        print("⚡️ [DEBUG] Saving session for Pokémon: \(manager.currentPokemon?.name ?? "Unknown")")
        print("⚡️ [DEBUG] Session Duration: \(elapsedTime) seconds")
        print("⚡️ [DEBUG] Total Sessions Before Save: \(manager.currentPokemon?.sessions.count ?? 0)")

        manager.currentPokemon?.addSession(session)
        PersistenceManager.shared.save(manager: manager)
        
        DispatchQueue.main.async {
            self.manager.pokemons = self.manager.pokemons.map { $0 }
        }

        print("✅ [DEBUG] Total Sessions After Save: \(manager.currentPokemon?.sessions.count ?? 0)")
        
    }
    
    /// Converts seconds into a MM:SS format.
    func timeString(from seconds: Int) -> String {
        let minutes = seconds / 60
        let secs = seconds % 60
        return String(format: "%02d:%02d", minutes, secs)
    }
}
