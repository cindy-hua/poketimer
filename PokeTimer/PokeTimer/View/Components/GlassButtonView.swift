//
//  GlassButtonView.swift
//  PokeTimer
//
//  Created by HUA Cindy on 18/03/2025.
//

import SwiftUI

struct GlassButtonView: View {
    var imageName: String
    var action: () -> Void

    var body: some View {
        Button(action: action) {
            Image(imageName)
                .resizable()
                .renderingMode(.template)
                .scaledToFit()
                .frame(width: 30, height: 30)
                .foregroundColor(.clear)
                .overlay(
                    RadialGradient(
                        gradient: Gradient(colors: [
                            Color.pink.opacity(0.5),
                            Color.yellow,
//                            Color.clear
                        ]),
                        center: .center,
                        startRadius: 5,
                        endRadius: 25
                    )
                    .mask(
                        Image(imageName)
                            .resizable()
                            .renderingMode(.template)
                            .scaledToFit()
                    )
                )
                .shadow(color: Color.blue.opacity(0.5), radius: 4)
                .padding(12)
                .background(
                    Circle()
                        .fill(Color.white.opacity(0.15)) // Softer glass effect
                        .background(.ultraThinMaterial)
                        .blur(radius: 8)
                )
                .overlay(
                    Circle()
                        .stroke(Color.white.opacity(0.3), lineWidth: 1)
                )
                .shadow(color: Color.yellow.opacity(0.4), radius: 6)
                .shadow(color: Color.purple.opacity(0.4), radius: 10)
        }
        .buttonStyle(.plain)
    }
}

#Preview {
    GlassButtonView(imageName: "pokemon_icon") {}
}
