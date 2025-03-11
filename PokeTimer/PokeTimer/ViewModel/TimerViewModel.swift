//
//  TimerViewModel.swift
//  PokeTimer
//
//  Created by HUA Cindy on 25/02/2025.
//

import Foundation

@Observable
class TimerViewModel {
    // Timer-related states.
    var remainingSeconds: Int
    var isRunning = false
    var isSessionCompleted = false
    
    private var timer: Timer?
    private var startTime: Date?
    let duration: Int
    
    init(duration: Int) {
        self.duration = duration
        self.remainingSeconds = duration
    }
    
    /// Starts the timer.
    func startTimer() {
        guard !isRunning else { return }
        remainingSeconds = duration
        startTime = Date()
        isRunning = true
        
        print("⏳ [DEBUG] Timer started for \(duration) seconds")
        
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { [weak self] t in
            guard let self = self else { return }
            if self.remainingSeconds > 0 {
                self.remainingSeconds -= 1
            } else {
                t.invalidate()
                self.isRunning = false
                self.isSessionCompleted = true
                print("✅ [DEBUG] Timer completed, isSessionCompleted = \(self.isSessionCompleted)")
            }
        }
    }
    
    /// Stops the timer early and saves an incomplete session.
    func stopTimer(pokemonManager: PokemonManager, sessionManager: SessionManager) {
        timer?.invalidate()
        timer = nil
        isRunning = false
        isSessionCompleted = false

        print("🛑 [DEBUG] Timer stopped manually")
        saveSession(pokemonManager: pokemonManager, sessionManager: sessionManager, completed: false)
    }


    /// Saves the session, associating it with the current Pokémon.
    func saveSession(pokemonManager: PokemonManager, sessionManager: SessionManager, completed: Bool) {
        print("💾 [DEBUG] saveSession() called, completed = \(completed)")
        guard let currentPokemonID = pokemonManager.currentPokemonID else {
            print("❌ [DEBUG] No current Pokémon selected, cannot save session!")
            return
        }

        let endTime = Date()
        let elapsedTime = completed ? duration : Int(endTime.timeIntervalSince(startTime ?? endTime))

        let session = Session(
            id: UUID(),
            duration: elapsedTime,
            startTime: startTime ?? endTime,
            endTime: endTime,
            completed: completed,
            pokemonID: currentPokemonID
        )

        sessionManager.addSession(session) // ✅ SessionManager handles sessions
        pokemonManager.processCompletedSession(session) // ✅ Let PokemonManager process XP

        print("✅ [DEBUG] Saved session for Pokémon ID: \(currentPokemonID), Duration: \(elapsedTime) seconds")
    }
    
    /// Converts seconds into a MM:SS format.
    func timeString(from seconds: Int) -> String {
        let minutes = seconds / 60
        let secs = seconds % 60
        return String(format: "%02d:%02d", minutes, secs)
    }
}
