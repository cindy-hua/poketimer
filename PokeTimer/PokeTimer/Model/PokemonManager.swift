//
//  PokemonManager.swift
//  PokeTimer
//
//  Created by HUA Cindy on 06/03/2025.
//

import Foundation

// MARK: - Pokemon Manager
/// Manages a list of Pokémon and tracks the active one.
class PokemonManager: ObservableObject, Codable {
    @Published var pokemons: [Pokemon]
    @Published var currentPokemon: Pokemon?
    
    // Define coding keys for the properties you want to encode/decode.
    enum CodingKeys: String, CodingKey {
        case pokemons, currentPokemon
    }
    
    init() {
        let defaultPokemon = Pokemon(name: "Starter")
        self.pokemons = [defaultPokemon]
        self.currentPokemon = defaultPokemon
        print("🧩 [DEBUG] New PokemonManager Created at \(Unmanaged.passUnretained(self).toOpaque())")
    }
    
    // MARK: - Codable Conformance
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        // Decode the array of Pokémon.
        self.pokemons = try container.decode([Pokemon].self, forKey: .pokemons)
        // Decode the current Pokémon if available.
        self.currentPokemon = try container.decodeIfPresent(Pokemon.self, forKey: .currentPokemon)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        // Encode the array of Pokémon.
        try container.encode(pokemons, forKey: .pokemons)
        // Encode the current Pokémon.
        try container.encode(currentPokemon, forKey: .currentPokemon)
    }
    
    func addPokemon(_ pokemon: Pokemon) {
        pokemons.append(pokemon)
        if currentPokemon == nil {
            currentPokemon = pokemon
        }
    }
    
    func selectPokemon(_ pokemon: Pokemon) {
        currentPokemon = pokemon
    }
    
    func addSessionToCurrentPokemon(_ session: Session) {
        currentPokemon?.addSession(session)  
        objectWillChange.send()
    }
}
