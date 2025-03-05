//
//  TimerView.swift
//  PokeTimer
//
//  Created by HUA Cindy on 25/02/2025.
//

import SwiftUI

struct TimerView: View {
    @StateObject var viewModel: TimerViewModel
    @State private var showSessionSavedAlert = false
    
    @Environment(\.dismiss) var dismiss
    
    init(duration: Int, manager: PokemonManager) {
        _viewModel = StateObject(wrappedValue: TimerViewModel(duration: duration, manager: manager))
    }
    
    var body: some View {
        VStack(spacing: 40) {
            // Countdown Timer Display.
            Text(viewModel.timeString(from: viewModel.remainingSeconds))
                .font(.system(size: 50, weight: .bold, design: .monospaced))
                .animation(.easeInOut, value: viewModel.remainingSeconds)
            
            // Stop Button.
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
        .padding()
        .navigationTitle("Focus Timer")
        .alert(isPresented: $showSessionSavedAlert) {
            Alert(
                title: Text("Session Completed"),
                message: Text("Your focus session has been saved."),
                dismissButton: .default(Text("OK"), action: { dismiss() })
            )
        }
        .onAppear {
            viewModel.startTimer()
        }
        .onChange(of: viewModel.isSessionCompleted) {
            showSessionSavedAlert = viewModel.isSessionCompleted
        }
    }


}

#Preview {
    let manager = PokemonManager()
    return TimerView(duration: 5 * 60, manager: manager).environmentObject(manager)
}
