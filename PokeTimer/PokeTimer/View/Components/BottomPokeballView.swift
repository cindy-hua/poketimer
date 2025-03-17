//
//  BottomPokeballView.swift
//  PokeTimer
//
//  Created by HUA Cindy on 17/03/2025.
//

import SwiftUI

struct BottomPokeballView: View {
    var size: CGFloat
    var body: some View {
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
    }
}
