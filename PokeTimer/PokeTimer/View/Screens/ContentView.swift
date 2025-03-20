//
//  ContentView.swift
//  PokeTimer
//
//  Created by HUA Cindy on 24/02/2025.
//

import SwiftUI

struct ContentView: View {
    @Environment(PokemonManager.self) var pokemonManager
    @Environment(SessionManager.self) var sessionManager

    @StateObject private var gestureController = GestureController()

    @State private var viewModel: ContentViewModel

    init(pokemonManager: PokemonManager, sessionManager: SessionManager, persistenceManager: PersistenceManager = .shared) {
        _viewModel = State(initialValue: ContentViewModel(
            pokemonManager: pokemonManager,
            sessionManager: sessionManager,
            persistenceManager: persistenceManager
        ))
    }
    
    @State private var rotationAngle: Double = 0
    @State private var accumulatedRotation: Double = 0
    @State private var navigateToTimerView: Bool = false

    var body: some View {
        NavigationStack {
            ZStack {
                GlassBackgroundOverlay()

                VStack(spacing: 40) {
                    NavigationButtonsView()
                    
                    TimerTextView(viewModel: $viewModel)
                    
                    PokemonInfoView(
                        selectedDuration: $viewModel.selectedDuration,
                        activeGesture: $gestureController.activeGesture,
                        rotationAngle: $rotationAngle,
                        accumulatedRotation: $accumulatedRotation,
                        navigateToTimerView: $navigateToTimerView
                    )
                }
            }
            .navigationDestination(isPresented: $navigateToTimerView) {
                TimerView(
                    duration: TimeFormatterUtil.minutesToSeconds(viewModel.selectedDuration),
                    pokemonManager: pokemonManager,
                    sessionManager: sessionManager
                )
            }
        }
        .navigationTitle("Focus Session")
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
}
