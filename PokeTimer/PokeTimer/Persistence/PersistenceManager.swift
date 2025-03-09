//
//  PersistenceManager.swift
//  PokeTimer
//
//  Created by HUA Cindy on 24/02/2025.
//

import Foundation

class PersistenceManager {
    static let shared = PersistenceManager()
    
    private let fileURL: URL
    
    private init() {
        // Locate the app's documents directory.
        let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        // Create a file URL for our data.
        fileURL = documentsDirectory.appendingPathComponent("pokemonManager.json")
        print("📂 [DEBUG] JSON File Path: \(fileURL.path)")
    }
    
    /// Saves the provided PokemonManager instance to disk.
    func save(manager: PokemonManager) {
        do {
            let encoder = JSONEncoder()
            encoder.outputFormatting = .prettyPrinted  // Optional: for easier reading.
            let data = try encoder.encode(manager)
            try data.write(to: fileURL, options: [.atomicWrite])
            print("Data saved successfully to \(fileURL)")
        } catch {
            print("Error saving PokemonManager: \(error)")
        }
    }
    
    /// Loads and returns a PokemonManager instance from disk.
    func loadManager() -> PokemonManager? {
        do {
            let data = try Data(contentsOf: fileURL)
            let decoder = JSONDecoder()
            let manager = try decoder.decode(PokemonManager.self, from: data)
            print("Data loaded successfully from \(fileURL)")
            return manager
        } catch {
            print("Error loading PokemonManager: \(error)")
            return nil
        }
    }
    
    func resetManager() {
        do {
            try FileManager.default.removeItem(at: fileURL)
            print("🗑 [DEBUG] JSON file deleted. Restart the app to start fresh.")
        } catch {
            print("❌ [DEBUG] Error deleting JSON file: \(error)")
        }
    }
}


