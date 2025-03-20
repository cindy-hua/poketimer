//
//  GlowingOverlayView.swift
//  PokeTimer
//
//  Created by HUA Cindy on 20/03/2025.
//

import SwiftUI

struct GlowingOverlayView: View {
    @Binding var animateGlow: Bool
    
    var body: some View {
        ZStack {
                // 🌅 Outer Glow (Warm Yellow-Orange-Purple)
                Circle()
                    .stroke(
                        RadialGradient(
                            gradient: Gradient(colors: [
                                Color.yellow.opacity(0.85),
                                Color.orange.opacity(0.7),
                                Color.purple.opacity(0.3),
                                Color.clear
                            ]),
                            center: .center,
                            startRadius: 10,
                            endRadius: 200
                        ),
                        lineWidth: 35
                    )
                    .blur(radius: 35)
                    .opacity(animateGlow ? 1.0 : 0.3)

                // 🌄 Mid Glow (Blended Orange & Purple, Softer Intensity)
                Circle()
                    .stroke(
                        RadialGradient(
                            gradient: Gradient(colors: [
                                Color.orange.opacity(0.4),
                                Color.purple.opacity(0.3),
                                Color.clear
                            ]),
                            center: .center,
                            startRadius: 5,
                            endRadius: 150
                        ),
                        lineWidth: 25
                    )
                    .blur(radius: 25)
                    .opacity(animateGlow ? 0.7 : 0.2)

                // 🌙 Inner Glow (Soft White & Blue for Subtle Shine)
                Circle()
                    .fill(
                        RadialGradient(
                            gradient: Gradient(colors: [
                                Color.white.opacity(0.2),
                                Color.purple.opacity(0.2),
                                Color.clear
                            ]),
                            center: .center,
                            startRadius: 5,
                            endRadius: 80
                        )
                    )
                    .blur(radius: 15)
                    .opacity(animateGlow ? 0.7 : 0.2)

                // ✨ Softest Core Glow (Warm White Focus Point)
                Circle()
                    .fill(Color.white.opacity(0.3))
                    .frame(width: 80, height: 80)
                    .blur(radius: 15)
                    .opacity(animateGlow ? 0.5 : 0.2)
            }
            .frame(width: 200, height: 200)
            .opacity(animateGlow ? 1.0 : 0.4) 
            .animation(.easeInOut(duration: 1.8).repeatForever(autoreverses: true), value: animateGlow)
        }
}

#Preview {
    @State var animateGlow = true
    return GlowingOverlayView(animateGlow: $animateGlow)
}
