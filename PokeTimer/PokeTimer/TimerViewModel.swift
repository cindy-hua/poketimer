//
//  TimerViewModel.swift
//  PokeTimer
//
//  Created by HUA Cindy on 25/02/2025.
//

import Foundation

class TimerViewModel: ObservableObject {
    @Published var remainingSeconds: Int
    @Published var isRunning = false
    
    private var timer: Timer?
    private var startTime: Date?
    let duration: Int
    
    init(duration: Int) {
        self.duration = duration
        self.remainingSeconds = duration
    }
    
    /// Starts the timer with a specified duration (in seconds).
    func startTimer(completion: @escaping (Session) -> Void) {
        startTime = Date()
        isRunning = true
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { [weak self] t in
            guard let self = self else { return }
            if self.remainingSeconds > 0 {
                self.remainingSeconds -= 1
            } else {
                t.invalidate()
                self.isRunning = false
                let endTime = Date()
                let session = Session(
                    duration: self.duration,
                    startTime: self.startTime ?? Date(),
                    endTime: endTime,
                    completed: true,
                    pokemonID: UUID()
                )
                completion(session)
            }
        }
    }
    
    /// Stops the current timer.
    func stopTimer(completion: @escaping (Session) -> Void) {
        timer?.invalidate()
        timer = nil
        isRunning = false
        let endTime = Date()
        let elapsedTime = Int(endTime.timeIntervalSince(startTime ?? endTime))
        let session = Session(
            duration: elapsedTime,
            startTime: startTime ?? endTime,
            endTime: endTime,
            completed: false,
            pokemonID: UUID()
        )
        completion(session)
    }
    
    /// Converts seconds into a MM:SS format.
    func timeString(from seconds: Int) -> String {
        let minutes = seconds / 60
        let secs = seconds % 60
        return String(format: "%02d:%02d", minutes, secs)
    }
}
