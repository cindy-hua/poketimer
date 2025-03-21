//
//  PokemonSpecies.swift
//  PokeTimer
//
//  Created by HUA Cindy on 17/03/2025.
//

import Foundation

//enum PokemonSpecies: String, Codable, CaseIterable {
//    case pikachu, bulbasaur, charmander, squirtle, unknown
//    
//    /// Returns a human-readable name (e.g., "Bulbasaur" instead of "bulbasaur").
//    var displayName: String {
//        switch self {
//        case .pikachu: return "Pikachu"
//        case .bulbasaur: return "Bulbasaur"
//        case .charmander: return "Charmander"
//        case .squirtle: return "Squirtle"
//        case .unknown: return "Unknown"
//        }
//    }
//
//    /// Returns the corresponding image name for each Pokémon species.
//    var imageName: String {
//        return self.rawValue
//    }
//}

// Introduce the new PokemonSpecies struct
struct PokemonSpecies: Identifiable, Codable, Hashable {
    let id: Int
    let name: String
    let types: [String]
    let spriteFront: String
    let spriteBack: String?
    let spriteShiny: String?
    let evolutionChain: [String]

    var displayName: String {
        return name.capitalized
    }
}
