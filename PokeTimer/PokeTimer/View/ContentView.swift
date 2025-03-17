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
    @Environment(\.themeManager) var themeManager

    @StateObject private var gestureController = GestureController() // Shared Gesture State

    @State private var viewModel: ContentViewModel

    init(pokemonManager: PokemonManager, sessionManager: SessionManager, persistenceManager: PersistenceManager = .shared) {
        _viewModel = State(initialValue: ContentViewModel(
            pokemonManager: pokemonManager,
            sessionManager: sessionManager,
            persistenceManager: persistenceManager
        ))
    }
    
    @State private var rotationAngle: Double = 0
    @State private var lastAngle: Double = 0
    @State private var accumulatedRotation: Double = 0 // Tracks full rotation
    @State private var navigateToTimerView: Bool = false

    var body: some View {
        NavigationStack {
            ZStack {                
                GlassBackgroundOverlay()

                VStack(spacing: 40) {
                    PokemonInfoView(
                        selectedDuration: $viewModel.selectedDuration,
                        activeGesture: $gestureController.activeGesture,
                        rotationAngle: $rotationAngle,
                        navigateToTimerView: $navigateToTimerView 
                    )
                    
                    Text("\(viewModel.selectedDuration) min")
                        .font(.title)
                        .bold()
                        .padding(.top, 10)
                        .foregroundColor(.black)
                    
                    NavigationButtonsView()
                }
            }
            .gesture(detectCircularGesture())
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
    
    // MARK: - Improved Circular Gesture for Timer Adjustment
    private func detectCircularGesture() -> some Gesture {
        DragGesture(minimumDistance: 10)
            .onChanged { value in
                guard gestureController.activeGesture == .none || gestureController.activeGesture == .rotating else { return }
                gestureController.activeGesture = .rotating

                let center = CGPoint(x: UIScreen.main.bounds.width / 2, y: UIScreen.main.bounds.height / 2)
                let touchPoint = value.location
                let deltaX = touchPoint.x - center.x
                let deltaY = touchPoint.y - center.y
                let newAngle = atan2(deltaY, deltaX) * (180 / .pi)

                let angleDiff = newAngle - lastAngle

                if abs(angleDiff) > 1 { // Reduced sensitivity
                    accumulatedRotation += angleDiff // Track total rotation
                    rotationAngle += angleDiff

                    // Every 45° rotation adjusts the timer
                    if abs(accumulatedRotation) > 45 {
                        if accumulatedRotation > 0 {
                            viewModel.selectedDuration += 1 // Clockwise
                        } else {
                            viewModel.selectedDuration = max(1, viewModel.selectedDuration - 1) // Counterclockwise, prevent <1
                        }
                        accumulatedRotation = 0 // Reset after update
                    }
                }

                lastAngle = newAngle
            }
            .onEnded { _ in
                withAnimation(.easeOut(duration: 0.3)) { rotationAngle = 0 } // Reset smoothly
                accumulatedRotation = 0 // Reset accumulated rotation
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                    gestureController.activeGesture = .none // Unlock gestures
                }
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
