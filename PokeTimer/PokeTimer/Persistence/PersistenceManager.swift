//
//  PersistenceManager.swift
//  PokeTimer
//
//  Created by HUA Cindy on 24/02/2025.
//

import Foundation

// MARK: - Persistence Manager
/// Handles saving and loading of PokemonManager and SessionManager separately.
class PersistenceManager {
    static let shared = PersistenceManager()

    private let pokemonFileURL: URL
    private let sessionFileURL: URL

    private init() {
        let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        pokemonFileURL = documentsDirectory.appendingPathComponent("pokemonManager.json")
        sessionFileURL = documentsDirectory.appendingPathComponent("sessionManager.json")
    }

    // MARK: - Save Functions

    /// Saves the provided PokemonManager instance to disk.
    func savePokemonManager(_ manager: PokemonManager) {
        do {
            let data = try JSONEncoder().encode(manager)
            try data.write(to: pokemonFileURL, options: [.atomicWrite])

            // ✅ Debugging: Check if file exists after writing
            if FileManager.default.fileExists(atPath: pokemonFileURL.path) {
                print("✅ PokemonManager saved successfully at: \(pokemonFileURL.path)")
            } else {
                print("❌ Failed to save PokemonManager: File not found after write")
            }

            // ✅ Debugging: Check file contents
            let jsonString = String(data: data, encoding: .utf8) ?? "⚠️ Failed to convert JSON"
            print("📝 [DEBUG] Saved PokemonManager JSON: \(jsonString)")

        } catch {
            print("❌ Error saving PokemonManager: \(error)")
        }
    }

    /// Saves the provided SessionManager instance to disk.
    func saveSessionManager(_ manager: SessionManager) {
        do {
            let data = try JSONEncoder().encode(manager.sessions) // Only need to store sessions
            try data.write(to: sessionFileURL, options: [.atomicWrite])
            print("✅ SessionManager saved successfully")
        } catch {
            print("❌ Error saving SessionManager: \(error)")
        }
    }

    // MARK: - Load Functions

    /// Loads and returns a PokemonManager instance from disk.
    func loadPokemonManager() -> PokemonManager {
        if !FileManager.default.fileExists(atPath: pokemonFileURL.path) {
            print("⚠️ pokemonManager.json not found. Creating a new one.")

            let newManager = PokemonManager()
            savePokemonManager(newManager) // ✅ Force file creation
            return newManager
        }

        do {
            let data = try Data(contentsOf: pokemonFileURL)

            // ✅ Debugging: Check file size
            print("📝 [DEBUG] Loaded JSON file size: \(data.count) bytes")

            let manager = try JSONDecoder().decode(PokemonManager.self, from: data)
            print("✅ PokemonManager loaded successfully")
            return manager

        } catch {
            print("⚠️ Error loading PokemonManager: \(error)")

            // ✅ Debugging: Check JSON content before failing
            if let jsonString = try? String(contentsOf: pokemonFileURL, encoding: .utf8) {
                print("📝 [DEBUG] Corrupted JSON content: \(jsonString)")
            } else {
                print("⚠️ [DEBUG] Could not read JSON file content.")
            }

            let newManager = PokemonManager()
            savePokemonManager(newManager)  // ✅ Ensure file is saved
            return newManager
        }
    }

    /// Loads and returns a SessionManager instance from disk.
    func loadSessionManager() -> SessionManager {
        do {
            let data = try Data(contentsOf: sessionFileURL)
            let sessions = try JSONDecoder().decode([Session].self, from: data)
            let manager = SessionManager()
            manager.restoreSessions(from: sessions)
            print("✅ SessionManager loaded successfully")
            return manager
        } catch {
            print("⚠️ Error loading SessionManager: \(error). Creating a new one.")
            let newManager = SessionManager()
            saveSessionManager(newManager) 
            return newManager
        }
    }

    // MARK: - Reset Function

    /// Deletes saved data and resets both managers.
    func resetAllData() {
        try? FileManager.default.removeItem(at: pokemonFileURL)
        try? FileManager.default.removeItem(at: sessionFileURL)
        print("🗑 All saved data deleted.")
    }
}
