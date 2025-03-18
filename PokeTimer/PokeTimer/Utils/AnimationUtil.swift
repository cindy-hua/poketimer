//
//  AnimationUtil.swift
//  PokeTimer
//
//  Created by HUA Cindy on 13/03/2025.
//

import SwiftUI

/// Detects a circular gesture to adjust the timer
struct CircularGesture {
    @Binding var rotationAngle: Double
    @Binding var accumulatedRotation: Double
    @Binding var selectedDuration: Int
    @Binding var activeGesture: GestureType
    var gestureController: GestureController

    @State private var gestureStartPoint: CGPoint = .zero
    @State private var rotationCenter: CGPoint = .zero
    @State private var isInsidePokeball: Bool = false

    /// Set this dynamically based on the Pokéball's size
    private let pokeballRadius: CGFloat = 125 // Half of the Pokéball size

    func detect() -> some Gesture {
        DragGesture(minimumDistance: 5)
            .onChanged { value in
                guard activeGesture == .none || activeGesture == .rotating else { return }
                activeGesture = .rotating

                if gestureStartPoint == .zero {
                    gestureStartPoint = value.startLocation

                    // Determine if the gesture starts inside the Pokéball
                    let screenCenter = CGPoint(x: UIScreen.main.bounds.width / 2, y: UIScreen.main.bounds.height / 2)
                    let distanceToCenter = hypot(gestureStartPoint.x - screenCenter.x, gestureStartPoint.y - screenCenter.y)
                    isInsidePokeball = distanceToCenter <= pokeballRadius

                    // Set rotation center dynamically
                    rotationCenter = isInsidePokeball ? screenCenter : gestureStartPoint
                }

                let touchPoint = value.location
                let deltaX = touchPoint.x - rotationCenter.x
                let deltaY = touchPoint.y - rotationCenter.y
                let newAngle = atan2(deltaY, deltaX) * (180 / .pi)

                let angleDiff = newAngle - (gestureController.lastAngle ?? newAngle)

                // Adjust sensitivity: smaller motions inside the Pokéball, larger outside
                let sensitivityMultiplier: Double = isInsidePokeball ? 1.5 : 1.2
                let adjustedAngleDiff = angleDiff * sensitivityMultiplier

                if abs(adjustedAngleDiff) > 1 {
                    accumulatedRotation += adjustedAngleDiff
                    rotationAngle += adjustedAngleDiff

                    // Change duration when enough rotation is accumulated
                    if abs(accumulatedRotation) > 30 {
                        if accumulatedRotation > 0 {
                            selectedDuration += 1
                        } else {
                            selectedDuration = max(1, selectedDuration - 1)
                        }
                        accumulatedRotation = 0
                    }
                }

                gestureController.lastAngle = newAngle
            }
            .onEnded { _ in
                withAnimation(.easeOut(duration: 0.3)) { rotationAngle = 0 }
                accumulatedRotation = 0
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                    activeGesture = .none
                }
                gestureStartPoint = .zero // Reset for the next gesture
            }
    }
}


// MARK: - Hold and Release Gesture (For Starting Timer)
struct HoldAndReleaseGesture {
    @Binding var isHolding: Bool
    @Binding var glowOpacity: Double
    @Binding var animateGlow: Bool
    @Binding var scaleEffect: CGFloat
    @Binding var navigateToTimerView: Bool
    @State private var hapticTimer: Timer?

    func detect(startHaptic: @escaping () -> Void, stopHaptic: @escaping () -> Void) -> some Gesture {
        LongPressGesture(minimumDuration: 1.5)
            .onChanged { isPressing in
                if isPressing {
                    print("🟡 [DEBUG] Press started, waiting for 1.5s...")
                }
            }
            .onEnded { _ in
                print("🟠 [DEBUG] Long press detected! Starting glow & haptic.")

                DispatchQueue.main.async {
                    isHolding = true
                    glowOpacity = 1.0
                    animateGlow = true

                    withAnimation(.easeInOut(duration: 0.8).repeatForever(autoreverses: true)) {
                        scaleEffect = 1.2
                    }

                    startHaptic()
                }
            }
            .sequenced(before: DragGesture(minimumDistance: 0))
            .onEnded { _ in
                print("🟢 [DEBUG] Press released! Stopping glow and starting timer.")

                DispatchQueue.main.async {
                    stopHaptic()
                    withAnimation {
                        scaleEffect = 1.0
                        glowOpacity = 0.0
                        animateGlow = false
                    }
                    isHolding = false
                }

                DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                    navigateToTimerView = true
                }
            }
    }
}

// MARK: - Swipe Gesture (For Switching Pokémon)
struct SwipeGesture {
    @Binding var offsetX: CGFloat
    @Binding var activeGesture: GestureType
    var pokemonManager: PokemonManager

    func detect() -> some Gesture {
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
