//
//  TimerTextView.swift
//  PokeTimer
//
//  Created by HUA Cindy on 19/03/2025.
//

import SwiftUI

struct TimerTextView: View {
    var body: some View {
        Text("\(viewModel.selectedDuration) min")
            .font(.system(size: 34, weight: .bold, design: .rounded)) // ✅ Slightly more dynamic font
            .foregroundStyle(
                LinearGradient( // ✅ Gold & Purple Pokémon Themed Gradient
                    gradient: Gradient(colors: [Color.yellow.opacity(0.9), Color.purple.opacity(0.8)]),
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
            )
            .shadow(color: Color.yellow.opacity(0.5), radius: 4, x: 0, y: 2) // ✅ Soft Glow
            .padding(.top, 10)
            .padding(.horizontal, 20)
            .background(
                Capsule()
                    .fill(Color.white.opacity(0.15)) // ✅ Subtle glass effect
                    .background(.ultraThinMaterial)
                    .blur(radius: 5)
            )
            .overlay(
                Capsule()
                    .stroke(
                        LinearGradient( // ✨ Shiny Pokémon Badge Effect
                            gradient: Gradient(colors: [Color.yellow.opacity(0.7), Color.purple.opacity(0.6)]),
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        ),
                        lineWidth: 2
                    )
            )
            .shadow(color: Color.purple.opacity(0.6), radius: 6) // ✅ Legendary Glow
    }
}

#Preview {
    TimerTextView()
}
