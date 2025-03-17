//
//  PokeballView.swift
//  PokeTimer
//
//  Created by HUA Cindy on 13/03/2025.
//

import SwiftUI

struct PokeballView: View {
    var size: CGFloat // Customizable size
    @State private var glowOpacity: Double = 0.6

    var body: some View {
        ZStack {
            // Outer Glassy Sphere (Transparent)
            Circle()
                .fill(
                    RadialGradient(
                        gradient: Gradient(colors: [
                            Color.blue.opacity(0.15),
                            Color.clear
                        ]),
                        center: .center, startRadius: 10, endRadius: size / 2
                    )
                )
                .frame(width: size, height: size)
                .background(.ultraThinMaterial)
                .blur(radius: 5)
                .shadow(color: Color.blue.opacity(0.4), radius: 10)

            // Inner Glow
            Circle()
                .strokeBorder(
                    RadialGradient(
                        gradient: Gradient(colors: [
                            Color.blue.opacity(0.5),
                            Color.purple.opacity(0.1)
                        ]),
                        center: .center, startRadius: 10, endRadius: size / 6
                    ),
                    lineWidth: 5
                )
                .frame(width: size * 0.95, height: size * 0.95)
                .blur(radius: 3)

            // Pokémon (Inside Pokéball)
            Image("pikachu") // Your Pokémon image
                .resizable()
                .scaledToFit()
                .frame(width: size * 1.3, height: size * 1.3)
                .clipShape(Circle())
                .opacity(0.95) // Slight transparency to blend inside the ball
                .blur(radius: 1.1) // Subtle blur to simulate being inside glass

            // **Glass-Like Band Instead of Black**
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



            // **New Glass Reflection Layer** (To simulate the Pokémon inside)
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
        .frame(width: size, height: size)
        .clipShape(Circle())
        .shadow(color: Color.purple.opacity(0.3), radius: 15)
    }
}

#Preview {
    PokeballView(size: 200)
}
