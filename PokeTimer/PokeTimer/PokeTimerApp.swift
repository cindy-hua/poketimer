//
//  PokeTimerApp.swift
//  PokeTimer
//
//  Created by HUA Cindy on 24/02/2025.
//

import SwiftUI

@main
struct PokeTimerApp: App {
    @StateObject var manager = PokemonManager()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(manager)
        }
    }
}
