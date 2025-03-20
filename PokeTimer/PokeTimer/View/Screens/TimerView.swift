//
//  TimerView.swift
//  PokeTimer
//
//  Created by HUA Cindy on 25/02/2025.
//

import SwiftUI

struct TimerView: View {
    @Environment(PokemonManager.self) var pokemonManager
    @Environment(SessionManager.self) var sessionManager
    @State var viewModel: TimerViewModel
    @State private var showSessionSavedAlert = false
    @Environment(\.dismiss) var dismiss
    
    init(duration: Int, pokemonManager: PokemonManager, sessionManager: SessionManager) {
        _viewModel = State(initialValue: TimerViewModel(duration: duration, pokemonManager: pokemonManager, sessionManager: sessionManager))
    }
    
    var body: some View {
        ZStack {
            GlassBackgroundOverlay()
            
            VStack(spacing: 40) {
                TimerCountdownView(viewModel: $viewModel)
                
                StopButtonView(viewModel: $viewModel)
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
                if viewModel.remainingSeconds != viewModel.duration {
                    viewModel.remainingSeconds = viewModel.duration // Reset timer
                }
                viewModel.startTimer()
            }
            .onChange(of: viewModel.isSessionCompleted) {
                print("🔄 [DEBUG] isSessionCompleted changed: \(viewModel.isSessionCompleted)")
                if viewModel.isSessionCompleted {
                    print("⚡️ [DEBUG] Triggering saveSession()")
                    viewModel.saveSession(completed: true)
                    showSessionSavedAlert = true
                }
        }
        }
    }
}

#Preview {
    TimerView(
        duration: 1500, // 25 min
        pokemonManager: PreviewData.pokemonManager,
        sessionManager: PreviewData.sessionManager
    )
    .environment(PreviewData.pokemonManager)
    .environment(PreviewData.sessionManager)
}

