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
                Color(red: 1.0, green: 0.85, blue: 0.9),  // Soft pink
                Color(red: 0.85, green: 0.95, blue: 1.0)  // Light blue
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
                .fill(Color.white.opacity(0.2))
                .background(.ultraThinMaterial)
                .frame(width: 350, height: 400)
                .blur(radius: 20)
                .offset(y: -50)
        }
    }
}

#Preview {
    GlassBackgroundOverlay()
}
