//
//  PokeTimerApp.swift
//  PokeTimer
//
//  Created by HUA Cindy on 24/02/2025.
//

import SwiftUI

@main
struct PokeTimerApp: App {
    @StateObject var manager: PokemonManager = {
        // Try to load an existing manager, or create a new one if none exists.
        PersistenceManager.shared.loadManager() ?? PokemonManager()
    }()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(manager)
        }
    }
}
