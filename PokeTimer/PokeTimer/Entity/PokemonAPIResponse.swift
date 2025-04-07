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
    let front_default: String?
    let back_default: String?
    let front_shiny: String?
    
    let other: OtherSprites?
}

struct OtherSprites: Codable {
    let dream_world: DreamWorldSprites?
    let official_artwork: OfficialArtworkSprites?
    let showdown: ShowdownSprites?
    let home: HomeSprites?
}

struct DreamWorldSprites: Codable {
    let front_default: String?
}

struct OfficialArtworkSprites: Codable {
    let front_default: String?
}

struct ShowdownSprites: Codable {
    let front_default: String?
}

struct HomeSprites: Codable {
    let front_default: String?
}
