//
//  StopButtonView.swift
//  PokeTimer
//
//  Created by HUA Cindy on 20/03/2025.
//

import SwiftUI

struct StopButtonView: View {
    @Binding var viewModel: TimerViewModel
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        Button(action: {
            viewModel.stopTimer()
            dismiss()
        }) {
            Text("Stop")
                .font(.title)
                .frame(minWidth: 0, maxWidth: .infinity)
                .padding()
                .foregroundColor(.white)
                .background(Color.red)
                .cornerRadius(10)
        }
        .padding(.horizontal)
    }
}

#Preview {
    @State var viewModel = TimerViewModel(duration: 2500, pokemonManager: PreviewData.pokemonManager, sessionManager: PreviewData.sessionManager)
    return StopButtonView(viewModel: $viewModel)
}
