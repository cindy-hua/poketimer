//
//  BackgroundView.swift
//  PokeTimer
//
//  Created by HUA Cindy on 17/03/2025.
//

import SwiftUI

struct SoftPokemonCenterBackground: View {
    var body: some View {
        LinearGradient(
            gradient: Gradient(colors: [
                Color.yellow.opacity(0.8),
                Color.purple.opacity(0.6)
            ]),
            startPoint: .topLeading,
            endPoint: .bottomTrailing
        )
        .edgesIgnoringSafeArea(.all)
    }
}

struct GlassBackgroundOverlay: View {
    var body: some View {
        ZStack {
            SoftPokemonCenterBackground()  // Base gradient

            RoundedRectangle(cornerRadius: 25)
                .fill(Color.white.opacity(0.05))
                .background(.ultraThinMaterial).opacity(0.1)
                .edgesIgnoringSafeArea(.all)
        }
    }
}

#Preview {
    GlassBackgroundOverlay()
}
