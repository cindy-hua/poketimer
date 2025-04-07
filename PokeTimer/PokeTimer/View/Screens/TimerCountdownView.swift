//
//  TimerCountdownView.swift
//  PokeTimer
//
//  Created by HUA Cindy on 20/03/2025.
//

import SwiftUI

struct TimerCountdownView: View {
    @Binding var viewModel: TimerViewModel
    @State private var animationAmount = 1.0
    
    var body: some View {
            Text(TimeFormatterUtil.timeString(from: viewModel.remainingSeconds))
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

#Preview {
    @State var viewModel = TimerViewModel(duration: 2500, pokemonManager: PreviewData.pokemonManager, sessionManager: PreviewData.sessionManager)
    return TimerCountdownView(viewModel: $viewModel)
}
