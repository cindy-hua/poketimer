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
    @Binding var navigateToTimerView: Bool

    @State private var offsetX: CGFloat = 0
    @State private var scaleEffect: CGFloat = 1.0
    @State private var isHolding: Bool = false
    @State private var glowOpacity: Double = 0.0
    @State private var animateGlow: Bool = false 
    @State private var hapticTimer: Timer?

    var body: some View {
        VStack {
            ZStack {
                PokeballView(size: 250)
                    .rotationEffect(.degrees(rotationAngle))

                // Glowing Overlay
                Circle()
                    .stroke(Color.blue.opacity(glowOpacity), lineWidth: 15)
                    .frame(width: 180, height: 180)
                    .blur(radius: 10)
                    .opacity(animateGlow ? 1.0 : 0.5)
                    .animation(.easeInOut(duration: 0.8).repeatForever(autoreverses: true), value: animateGlow)
            }
            .scaleEffect(scaleEffect) // Unified scaling effect
            .animation(.easeInOut(duration: 0.8).repeatForever(autoreverses: true), value: animateGlow)

            VStack {

                Text(pokemonManager.getCurrentPokemon()?.species.displayName ?? "Unknown")
                    .font(.title2)
                    .bold()
                    .foregroundColor(.black)

                HStack {
                    Text("XP: \(pokemonManager.getCurrentPokemon()?.xp ?? 0)")
                    Text("Level: \(pokemonManager.getCurrentPokemon()?.level ?? 1)")
                }
                .font(.headline)
            }
        }
        .gesture(detectSwipeGesture())
        .simultaneousGesture(detectHoldAndReleaseGesture())
    }

    // MARK: - Start Timer When Released
    private func detectHoldAndReleaseGesture() -> some Gesture {
        LongPressGesture(minimumDuration: 1.5)
            .onChanged { isPressing in
                if isPressing {
                    print("🟡 [DEBUG] Press started, waiting for 1.5s...")
                }
            }
            .onEnded { _ in
                print("🟠 [DEBUG] Long press detected! Starting glow & haptic.")

                // ✅ Start Glow & Haptic Feedback
                DispatchQueue.main.async {
                    isHolding = true
                    glowOpacity = 1.0
                    animateGlow = true

                    // Unified Pulsing Effect for Scale
                    withAnimation(.easeInOut(duration: 0.8).repeatForever(autoreverses: true)) {
                        scaleEffect = 1.2
                    }

                    startHapticFeedback() // Start haptic after long press completes
                }
            }
            .sequenced(before: DragGesture(minimumDistance: 0)) // Detect finger lift
            .onEnded { _ in
                print("🟢 [DEBUG] Press released! Stopping glow and starting timer.")

                // Stop Glow & Haptic When Released
                DispatchQueue.main.async {
                    stopHapticFeedback()
                    withAnimation {
                        scaleEffect = 1.0
                        glowOpacity = 0.0
                        animateGlow = false
                    }
                    isHolding = false
                }

                //  Navigate to Timer only after release
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                    navigateToTimerView = true
                }
            }
    }

    // MARK: - Swipe Left/Right (Switch Pokémon)
    private func detectSwipeGesture() -> some Gesture {
        DragGesture(minimumDistance: 20)
            .onChanged { _ in
                guard activeGesture == .none else { return }
                activeGesture = .swipingPokemon
            }
            .onEnded { gesture in
                if activeGesture == .swipingPokemon {
                    withAnimation(.easeInOut(duration: 0.3)) {
                        if gesture.translation.width < -50 {
                            pokemonManager.selectNextPokemon()
                            offsetX = -100
                        } else if gesture.translation.width > 50 {
                            pokemonManager.selectPreviousPokemon()
                            offsetX = 100
                        }
                        offsetX = 0
                    }
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                        activeGesture = .none
                    }
                }
            }
    }

    // MARK: - Start & Stop Haptic Feedback
    private func startHapticFeedback() {
        print("📳 [DEBUG] Haptic feedback started!")

        // ✅ Prevent multiple haptic timers running
        stopHapticFeedback()

        let generator = UIImpactFeedbackGenerator(style: .medium)
        generator.impactOccurred()

        // ✅ Haptic feedback loop
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

    return PokemonInfoView(
        selectedDuration: $selectedDuration,
        activeGesture: $activeGesture,
        rotationAngle: $rotationAngle,
        navigateToTimerView: $navigateToTimerView
    )
    .environment(PreviewData.pokemonManager)
    .environment(PreviewData.sessionManager)
}
