//
//  TimerTextView.swift
//  PokeTimer
//
//  Created by HUA Cindy on 19/03/2025.
//

import SwiftUI

struct TimerTextView: View {
    @Binding var viewModel: ContentViewModel
    @State private var animationAmount = 1.0 // Soft glow effect

    var body: some View {
        Text(TimeFormatterUtil.timeString(from: viewModel.selectedDuration))
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
//    @State var viewModel = ContentViewModel(
//        pokemonManager: PokemonManager(),
//        sessionManager: SessionManager(),
//        persistenceManager: PersistenceManager.shared
//    )
//    return TimerTextView(viewModel: $viewModel).environment(PreviewData.pokemonManager)
//        .environment(PreviewData.sessionManager)
//        .environment(PreviewData.themeManager)
//}
