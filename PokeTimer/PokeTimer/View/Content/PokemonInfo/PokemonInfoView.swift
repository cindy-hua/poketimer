//
//  PokemonInfoView.swift
//  PokeTimer
//
//  Created by HUA Cindy on 13/03/2025.
//

import SwiftUI

struct PokemonInfoView: View {
    @Environment(PokemonManager.self) var pokemonManager
    @Environment(SessionManager.self) var sessionManager
    @Binding var selectedDuration: Int
    @Binding var activeGesture: GestureType
    @Binding var rotationAngle: Double
    @Binding var accumulatedRotation: Double
    @Binding var navigateToTimerView: Bool

    @State private var offsetX: CGFloat = 0
    @State private var scaleEffect: CGFloat = 1.0
    @State private var isHolding: Bool = false
    @State private var glowOpacity: Double = 0.0
    @State private var animateGlow: Bool = false 
    @State private var hapticTimer: Timer?
    @StateObject private var gestureController = GestureController()

    var body: some View {
        VStack {
            ZStack {
                PokeballView(size: 250, rotationAngle: $rotationAngle)
                    .gesture(
                        CircularGesture(
                            rotationAngle: $rotationAngle,
                            accumulatedRotation: $accumulatedRotation,
                            selectedDuration: $selectedDuration,
                            activeGesture: $activeGesture,
                            gestureController: gestureController
                        ).detect()
                    )
                
                GlowingOverlayView(animateGlow: $animateGlow)
            }
            .scaleEffect(scaleEffect)

            PokemonCardView().padding(30)
        }
        .simultaneousGesture(
            SwipeGesture(
                offsetX: $offsetX,
                activeGesture: $activeGesture,
                pokemonManager: pokemonManager
            ).detect()
        )
        .simultaneousGesture(
            HoldAndReleaseGesture(
                isHolding: $isHolding,
                glowOpacity: $glowOpacity,
                animateGlow: $animateGlow,
                scaleEffect: $scaleEffect,
                navigateToTimerView: $navigateToTimerView
            ).detect(
                startHaptic: startHapticFeedback,
                stopHaptic: stopHapticFeedback
            )
        )
    }

    // MARK: - Start & Stop Haptic Feedback
    private func startHapticFeedback() {
        print("📳 [DEBUG] Haptic feedback started!")

        // Prevent multiple haptic timers running
        stopHapticFeedback()

        let generator = UIImpactFeedbackGenerator(style: .medium)
        generator.impactOccurred()

        // Haptic feedback loop
        hapticTimer = Timer.scheduledTimer(withTimeInterval: 0.3, repeats: true) { _ in
            generator.impactOccurred()
            print("📳 [DEBUG] Haptic feedback ongoing...")
        }
    }

    private func stopHapticFeedback() {
        print("📳 [DEBUG] Stopping haptic feedback")
        hapticTimer?.invalidate()
        hapticTimer = nil
    }
}



#Preview {
    // Create mock bindings
    @State var selectedDuration: Int = 60
    @State var activeGesture: GestureType = .none
    @State var rotationAngle: Double = 0.0
    @State var navigateToTimerView: Bool = false
    @State var accumulatedRotation: Double = 0.0

    return PokemonInfoView(
        selectedDuration: $selectedDuration,
        activeGesture: $activeGesture,
        rotationAngle: $rotationAngle,
        accumulatedRotation: $accumulatedRotation,
        navigateToTimerView: $navigateToTimerView
    )
    .environment(PreviewData.pokemonManager)
    .environment(PreviewData.sessionManager)
}
