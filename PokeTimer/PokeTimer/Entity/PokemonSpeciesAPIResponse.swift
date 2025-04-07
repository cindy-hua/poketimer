//
//  PokemonSpeciesAPIResponse.swift
//  PokeTimer
//
//  Created by HUA Cindy on 21/03/2025.
//

import Foundation

struct PokemonSpeciesAPIResponse: Codable {
    let evolution_chain: EvolutionChainURL?
}

struct EvolutionChainURL: Codable {
    let url: String
}
