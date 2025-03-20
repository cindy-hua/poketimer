//
//  StopButtonView.swift
//  PokeTimer
//
//  Created by HUA Cindy on 20/03/2025.
//

import SwiftUI

struct StopButtonView: View {
    var action: () -> Void

    var body: some View {
        Button(action: action) {
            Text("Stop")
                .font(.system(size: 26, weight: .semibold))
                .foregroundColor(Color.white.opacity(0.8))
                .shadow(color: Color.purple.opacity(0.2), radius: 2, x: 0, y: 2)
                .padding(.vertical, 14)
                .padding(.horizontal, 60)
                .background(
                    RoundedRectangle(cornerRadius: 24)
                        .fill(
                            LinearGradient(
                                gradient: Gradient(colors: [
                                    Color.yellow.opacity(0.5),
                                    Color.orange.opacity(0.9),
                                    Color.red.opacity(0.6),
                                ]),
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            )
                        )
                        .overlay(
                            RoundedRectangle(cornerRadius: 16)
                                .stroke(Color.orange.opacity(0.4), lineWidth: 1)
                        )
                        .shadow(color: Color.orange.opacity(0.6), radius: 10)
                        .shadow(color: Color.purple.opacity(0.6), radius: 15)
                )
        }
        .padding(.horizontal)
    }
}

#Preview {
    StopButtonView(action: {})
}
