//
//  PokeballView.swift
//  PokeTimer
//
//  Created by HUA Cindy on 13/03/2025.
//

import SwiftUI

struct PokeballView: View {
    var body: some View {
        ZStack {
            // Top Half (Red)
            Circle()
                .fill(Color.red)
                .frame(width: 200, height: 200)
                .clipShape(Rectangle().offset(y: -100)) // Crop the top half
            
            // Bottom Half (White)
            Circle()
                .fill(Color.white)
                .frame(width: 200, height: 200)
                .clipShape(Rectangle().offset(y: 100)) // Crop the bottom half

            // Pokeball Black Band
            Rectangle()
                .fill(Color.black)
                .frame(width: 200, height: 15)
                .offset(y: 0) // Keep centered
            
            // Center Button (Outer Black Border)
            Circle()
                .fill(Color.black)
                .frame(width: 50, height: 50)

            // Center Button (Inner White)
            Circle()
                .fill(Color.white)
                .frame(width: 40, height: 40)
        }
        .frame(width: 200, height: 200)
    }
}

#Preview {
    PokeballView()
}

