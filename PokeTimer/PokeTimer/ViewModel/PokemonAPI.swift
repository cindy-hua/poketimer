//
//  PokemonAPI.swift
//  PokeTimer
//
//  Created by HUA Cindy on 21/03/2025.
//

import Foundation

class PokemonAPI {
    static let shared = PokemonAPI()
    
    /// Fetch complete Pokémon details (basic info, species, and evolution chain)
    func fetchCompletePokemonData(name: String) async throws -> PokemonSpecies {
        // 🟢 1️⃣ Fetch Basic Pokémon Info
        let pokemonURL = "https://pokeapi.co/api/v2/pokemon/\(name.lowercased())"
        guard let url = URL(string: pokemonURL) else { throw URLError(.badURL) }
        
        let (pokemonData, _) = try await URLSession.shared.data(from: url)
        let pokemonDetails = try JSONDecoder().decode(PokemonAPIResponse.self, from: pokemonData)

        let id = pokemonDetails.id
        let types = pokemonDetails.types.map { $0.type.name.capitalized }
        
        let sprites = pokemonDetails.sprites
        let spriteFront = sprites.front_default ?? ""
        let spriteBack = sprites.back_default ?? ""
        let spriteShiny = sprites.front_shiny ?? ""
        
        let dreamWorld = sprites.other?.dream_world?.front_default ?? ""
        let officialArtwork = sprites.other?.official_artwork?.front_default ?? ""
        let showdown = sprites.other?.showdown?.front_default ?? ""
        let home = sprites.other?.home?.front_default ?? ""

        // 🟢 2️⃣ Fetch Pokémon Species Info (to get Evolution URL)
        let speciesURL = "https://pokeapi.co/api/v2/pokemon-species/\(id)"
        guard let speciesRequestURL = URL(string: speciesURL) else { throw URLError(.badURL) }

        let (speciesData, _) = try await URLSession.shared.data(from: speciesRequestURL)
        let speciesDetails = try JSONDecoder().decode(PokemonSpeciesAPIResponse.self, from: speciesData)

        guard let evolutionURLString = speciesDetails.evolution_chain?.url,
              let evolutionURL = URL(string: evolutionURLString) else { throw URLError(.badURL) }

        // 🟢 3️⃣ Fetch Evolution Chain
        let (evolutionData, _) = try await URLSession.shared.data(from: evolutionURL)
        let evolutionChain = try JSONDecoder().decode(PokemonEvolutionChainAPIResponse.self, from: evolutionData)

        let evolutionChainNames = extractEvolutionNames(from: evolutionChain.chain)

        return PokemonSpecies(
            id: id,
            name: name.capitalized,
            types: types,
            spriteFront: spriteFront,
            spriteBack: spriteBack,
            spriteShiny: spriteShiny,
            dreamWorld: dreamWorld,
            officialArtwork: officialArtwork,
            showdown: showdown,
            home: home,
            evolutionChain: []
        )
    }
    
    /// Recursively extract evolution names from the evolution chain
    private func extractEvolutionNames(from chain: EvolutionChainLink) -> [String] {
        var names = [chain.species.name.capitalized]

        if let evolvesTo = chain.evolves_to.first {
            names.append(contentsOf: extractEvolutionNames(from: evolvesTo))
        }

        return names
    }
}
