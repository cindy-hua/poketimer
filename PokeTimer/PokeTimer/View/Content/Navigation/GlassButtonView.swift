//
//  GlassButtonView.swift
//  PokeTimer
//
//  Created by HUA Cindy on 18/03/2025.
//

import SwiftUI

struct GlassButtonView: View {
    var imageName: String

    var body: some View {
        Image(imageName)
            .resizable()
            .renderingMode(.template)
            .scaledToFit()
            .frame(width: 30, height: 30)
            .foregroundColor(.clear)
            .overlay(
                Color.purple
                    .opacity(0.7)
                    .mask(
                        Image(imageName)
                            .resizable()
                            .renderingMode(.template)
                            .scaledToFit()
                    )
            )
            .shadow(color: Color.yellow.opacity(0.6), radius: 8)
            .padding(12)
            .background(
                Circle()
                    .fill(Color.white.opacity(0.5))
                    .blur(radius: 8)
            )
            .overlay(
                Circle()
                    .fill(Color.white.opacity(0.2))
                    .stroke(
                        LinearGradient(
                            gradient: Gradient(colors: [Color.yellow.opacity(0.7), Color.purple.opacity(0.5)]),
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        ),
                        lineWidth: 2
                    )
            )
            .shadow(color: Color.yellow.opacity(0.5), radius: 3)
            .buttonStyle(.plain)
    }
}


#Preview {
    GlassButtonView(imageName: "pokemon_icon") 
}
