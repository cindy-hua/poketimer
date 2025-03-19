//
//  TopPokeballView.swift
//  PokeTimer
//
//  Created by HUA Cindy on 17/03/2025.
//

import SwiftUI

struct TopPokeballView: View {
    var size: CGFloat // Customizable size
    @State private var glowOpacity: Double = 0.6
    
    var body: some View {
        // **Glass-Like Band**
        Rectangle()
            .fill(Color.white.opacity(0.1)) // Base translucency
            .background(.ultraThinMaterial)
            .frame(width: size, height: size * 0.075)
            .blur(radius: 2)
            .overlay(
                LinearGradient(
                    gradient: Gradient(colors: [
                        Color.white.opacity(0.3),
                        Color.gray.opacity(0.1),
                        Color.white.opacity(0.2)
                    ]),
                    startPoint: .top,
                    endPoint: .bottom
                )
            )


        // Center Button Outer Ring (Glassy)
        Circle()
            .strokeBorder(Color.white.opacity(0.6), lineWidth: 5)
            .frame(width: size * 0.25, height: size * 0.25)

        // Center Button Inner Glow
        Circle()
            .fill(RadialGradient(
                gradient: Gradient(colors: [
                    Color.yellow.opacity(glowOpacity),
                    Color.red.opacity(glowOpacity * 0.8),
                    Color.clear
                ]),
                center: .center, startRadius: 5, endRadius: size * 0.14
            ))
            .frame(width: size * 0.2, height: size * 0.2)
            .blur(radius: 3)
            .onAppear {
                withAnimation(Animation.easeInOut(duration: 2).repeatForever(autoreverses: true)) {
                    glowOpacity = 0.3 // Smooth glow animation
                }
            }

        // Glass Reflection Layer
        Circle()
            .fill(
                LinearGradient(
                    gradient: Gradient(colors: [
                        Color.white.opacity(0.3), // Light reflection
                        Color.clear
                    ]),
                    startPoint: .top,
                    endPoint: .bottom
                )
            )
            .frame(width: size, height: size / 2)
            .opacity(0.5)
            .offset(y: -size * 0.2) // Positioned on the upper part
    }
}


#Preview {
    return TopPokeballView(size: 200)
}
