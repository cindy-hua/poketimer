//
//  PokemonSpecies.swift
//  PokeTimer
//
//  Created by HUA Cindy on 17/03/2025.
//

import Foundation

// Introduce the new PokemonSpecies struct
struct PokemonSpecies: Identifiable, Codable, Hashable {
    let id: Int
    let name: String
    let types: [String]
    
    let spriteFront: String
    let spriteBack: String?
    let spriteShiny: String?
    
    let dreamWorld: String?
    let officialArtwork: String?
    let showdown: String?
    let home: String?
    
    let evolutionChain: [String]

    var displayName: String {
        return name.capitalized
    }
}
