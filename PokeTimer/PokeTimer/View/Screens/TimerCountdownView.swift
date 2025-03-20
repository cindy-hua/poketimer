//
//  TimerCountdownView.swift
//  PokeTimer
//
//  Created by HUA Cindy on 20/03/2025.
//

import SwiftUI

struct TimerCountdownView: View {
    @Binding var viewModel: TimerViewModel
    
    var body: some View {
        Text(TimeFormatterUtil.timeString(from: viewModel.remainingSeconds))
            .font(.system(size: 50, weight: .bold, design: .monospaced))
            .animation(.easeInOut, value: viewModel.remainingSeconds)
    }
}

#Preview {
    @State var viewModel = TimerViewModel(duration: 2500, pokemonManager: PreviewData.pokemonManager, sessionManager: PreviewData.sessionManager)
    return TimerCountdownView(viewModel: $viewModel)
}
