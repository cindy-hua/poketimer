//
//  TimerView.swift
//  PokeTimer
//
//  Created by HUA Cindy on 25/02/2025.
//

import SwiftUI

struct TimerView: View {
    @EnvironmentObject var manager: PokemonManager
    let duration: Int  // in seconds.
    
    // Timer-related states.
    @State private var remainingSeconds: Int = 0
    @State private var timer: Timer? = nil
    @State private var showSessionSavedAlert = false
    
    @Environment(\.dismiss) var dismiss
    
    // Record start time when the view is created.
    private let startTime = Date()
    
    // Initialize the remainingSeconds with the duration.
    init(duration: Int) {
        self.duration = duration
        _remainingSeconds = State(initialValue: duration)
    }
    
    var body: some View {
        VStack(spacing: 40) {
            // Countdown Timer Display.
            Text(timeString(from: remainingSeconds))
                .font(.system(size: 50, weight: .bold, design: .monospaced))
                .animation(.easeInOut, value: remainingSeconds)
            
            // Stop Button.
            Button(action: {
                stopTimer()
                dismiss()
            }) {
                Text("Stop")
                    .font(.title)
                    .frame(minWidth: 0, maxWidth: .infinity)
                    .padding()
                    .foregroundColor(.white)
                    .background(Color.red)
                    .cornerRadius(10)
            }
            .padding(.horizontal)
        }
        .padding()
        .navigationTitle("Focus Timer")
        .alert(isPresented: $showSessionSavedAlert) {
            Alert(
                title: Text("Session Completed"),
                message: Text("Your focus session has been saved."),
                dismissButton: .default(Text("OK"), action: { dismiss() })
            )
        }
        .onAppear {
            startTimer()
        }
    }

    // MARK: - Timer Functions
    func startTimer() {
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { t in
            if remainingSeconds > 0 {
                remainingSeconds -= 1
            } else {
                t.invalidate()
                let endTime = Date()
                let session = Session(
                    duration: duration,
                    startTime: startTime,
                    endTime: endTime,
                    completed: true,
                    pokemonID: manager.currentPokemon?.id ?? UUID() 
                )
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
    }
    
    func timeString(from seconds: Int) -> String {
        let minutes = seconds / 60
        let secs = seconds % 60
        return String(format: "%02d:%02d", minutes, secs)
    }
}

#Preview {
    TimerView(duration: 5 * 60).environmentObject(PokemonManager())
}
