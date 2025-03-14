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
    @State private var scaleEffect: CGFloat = 1.0 // For animation effect
    @State private var isHolding: Bool = false // Track long press state

    var body: some View {
        ZStack {
            PokeballView()
                .rotationEffect(.degrees(rotationAngle))
                .offset(x: offsetX, y: 0)
                .scaleEffect(scaleEffect)
                .gesture(detectSwipeGesture())
                .gesture(detectLongPressGesture())

            VStack {
                Image(systemName: "bolt.fill")
                    .resizable()
                    .frame(width: 80, height: 80)
                    .foregroundColor(.yellow)

                Text(pokemonManager.getCurrentPokemon()?.name ?? "Unknown")
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
    }

    // MARK: - ⏳ Long Press to Navigate to `TimerView`
    private func detectLongPressGesture() -> some Gesture {
        LongPressGesture(minimumDuration: 1.5) // Hold for 1.5 seconds
            .onChanged { _ in
                guard activeGesture == .none else { return }
                activeGesture = .holding // Lock all other gestures

                isHolding = true

                // 🔥 Start animation effect
                withAnimation(.easeInOut(duration: 0.3).repeatForever(autoreverses: true)) {
                    scaleEffect = 1.2 // Pokéball pulses
                }

                // 🎯 Haptic feedback (Taptic Engine)
                let generator = UIImpactFeedbackGenerator(style: .medium)
                generator.impactOccurred()
            }
            .onEnded { _ in
                // Trigger Navigation
                DispatchQueue.main.async {
                    navigateToTimerView = true
                }

                // Stop animation & reset
                withAnimation { scaleEffect = 1.0 }
                isHolding = false

                // Reset gesture lock after navigation
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    activeGesture = .none
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
}

//#Preview {
//    PokemonInfoView()
//        .environment(PreviewData.pokemonManager)
//}
