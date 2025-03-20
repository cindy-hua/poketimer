//
//  AnimatedTimerTextView.swift
//  PokeTimer
//
//  Created by HUA Cindy on 20/03/2025.
//

import SwiftUI

struct AnimatedTimerTextView: View {
    @Binding var timeValue: Int
    var formatter: (Int) -> String
    @State private var animationAmount = 1.0
    
    var body: some View {
        Text(formatter(timeValue))
            .font(.system(size: 60, weight: .medium, design: .monospaced))
            .foregroundStyle(
                LinearGradient(
                    gradient: Gradient(colors: [
                        Color.orange.opacity(0.8),
                        Color.purple.opacity(0.8)
                    ]),
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
            )
            .shadow(color: Color.white.opacity(0.5), radius: 2)
            .scaleEffect(animationAmount)
            .onAppear {
                withAnimation(Animation.easeInOut(duration: 2).repeatForever(autoreverses: true)) {
                    animationAmount = 1.02
                }
            }
    }
}

//#Preview {
//    AnimatedTimerTextView()
//}
