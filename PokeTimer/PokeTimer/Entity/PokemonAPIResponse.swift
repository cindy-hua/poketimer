//
//  PokemonAPIResponse.swift
//  PokeTimer
//
//  Created by HUA Cindy on 21/03/2025.
//

import Foundation

struct PokemonAPIResponse: Codable {
    let id: Int
    let name: String
    let types: [PokemonType]
    let sprites: PokemonSprites
}

struct PokemonType: Codable {
    let type: PokemonTypeName
}

struct PokemonTypeName: Codable {
    let name: String
}

struct PokemonSprites: Codable {
    let front_default: String
    let back_default: String?
    let front_shiny: String?
}
