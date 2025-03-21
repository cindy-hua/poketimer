//
//  PokemonEvolutionChainAPIResponse.swift
//  PokeTimer
//
//  Created by HUA Cindy on 21/03/2025.
//

import Foundation

struct PokemonEvolutionChainAPIResponse: Codable {
    let chain: EvolutionChainLink
}

struct EvolutionChainLink: Codable {
    let species: EvolutionSpecies
    let evolves_to: [EvolutionChainLink]
}

struct EvolutionSpecies: Codable {
    let name: String
}
