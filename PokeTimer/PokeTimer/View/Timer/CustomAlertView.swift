//
//  CustomAlertView.swift
//  PokeTimer
//
//  Created by HUA Cindy on 20/03/2025.
//

import SwiftUI

struct CustomAlertView: View {
    var title: String
    var message: String
    var action: () -> Void

    var body: some View {
        ZStack {
            // 🔹 Background Blur Effect
            Color.black.opacity(0.2)
                .background(.ultraThinMaterial)
                .edgesIgnoringSafeArea(.all)

            // ✨ Soft, Rounded Glassy Alert Box
            VStack(spacing: 16) {
                // 🔥 Title with Warm Glow
                Text(title)
                    .font(.title2)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .shadow(color: Color.orange.opacity(0.4), radius: 3, x: 0, y: 2)

                // 📝 Message with Softer White
                Text(message)
                    .font(.body)
                    .foregroundColor(.white.opacity(0.9))
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 20)

                // ✅ Rounded Action Button
                Button(action: action) {
                    Text("OK")
                        .font(.headline)
                        .padding(.horizontal, 40)
                        .padding(.vertical, 12)
                        .background(
                            RoundedRectangle(cornerRadius: 20)
                                .fill(
                                    LinearGradient(
                                        gradient: Gradient(colors: [
                                            Color.yellow.opacity(0.9),
                                            Color.orange.opacity(0.85),
                                            Color.purple.opacity(0.8)
                                        ]),
                                        startPoint: .topLeading,
                                        endPoint: .bottomTrailing
                                    )
                                )
                        )
                        .foregroundColor(.white)
                        .shadow(color: Color.orange.opacity(0.5), radius: 6)
                }
                .padding(.bottom, 10)
            }
            .frame(width: 320)
            .padding()
            .background(
                RoundedRectangle(cornerRadius: 25)
                    .fill(Color.purple.opacity(0.1))
                    .background(.ultraThinMaterial)
                    .clipShape(RoundedRectangle(cornerRadius: 25))
                    .shadow(color: Color.purple.opacity(0.3), radius: 10)
                    .shadow(color: Color.orange.opacity(0.3), radius: 25)
            )
            .transition(.scale)
        }
    }
}

#Preview {
    ZStack {
        GlassBackgroundOverlay()
        CustomAlertView(
            title: "Session Completed",
            message: "Your focus session has been saved.",
            action: {}
        )
    }
}
