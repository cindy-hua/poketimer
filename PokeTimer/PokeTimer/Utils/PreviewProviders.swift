//
//  PreviewProviders.swift
//  PokeTimer
//
//  Created by HUA Cindy on 13/03/2025.
//

import Foundation
import SwiftUI

struct PreviewData {
    // Pokémon Manager with diverse sample Pokémon
    static let pokemonManager: PokemonManager = {
        let manager = PokemonManager()
        
        let pikachuSpecies = PokemonSpecies(
            id: 25,
            name: "Pikachu",
            types: ["Electric"],
            spriteFront: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/25.png",
            spriteBack: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/back/25.png",
            spriteShiny: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/shiny/25.png",
            dreamWorld: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/dream-world/25.svg",
            officialArtwork: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/25.png",
            showdown: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/showdown/25.gif",
            home: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/home/25.png",
            evolutionChain: ["Pichu", "Pikachu", "Raichu"]
        )

        let charmanderSpecies = PokemonSpecies(
            id: 4,
            name: "Charmander",
            types: ["Fire"],
            spriteFront: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/4.png",
            spriteBack: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/back/4.png",
            spriteShiny: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/shiny/4.png",
            dreamWorld: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/dream-world/4.svg",
            officialArtwork: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/4.png",
            showdown: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/showdown/4.gif",
            home: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/home/4.png",
            evolutionChain: ["Charmander", "Charmeleon", "Charizard"]
        )

        let squirtleSpecies = PokemonSpecies(
            id: 7,
            name: "Squirtle",
            types: ["Water"],
            spriteFront: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/7.png",
            spriteBack: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/back/7.png",
            spriteShiny: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/shiny/7.png",
            dreamWorld: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/dream-world/7.svg",
            officialArtwork: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/7.png",
            showdown: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/showdown/7.gif",
            home: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/home/7.png",
            evolutionChain: ["Squirtle", "Wartortle", "Blastoise"]
        )

        let bulbasaurSpecies = PokemonSpecies(
            id: 1,
            name: "Bulbasaur",
            types: ["Grass", "Poison"],
            spriteFront: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/1.png",
            spriteBack: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/back/1.png",
            spriteShiny: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/shiny/1.png",
            dreamWorld: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/dream-world/1.svg",
            officialArtwork: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/1.png",
            showdown: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/showdown/1.gif",
            home: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/home/1.png",
            evolutionChain: ["Bulbasaur", "Ivysaur", "Venusaur"]
        )

        let gengarSpecies = PokemonSpecies(
            id: 94,
            name: "Gengar",
            types: ["Ghost", "Poison"],
            spriteFront: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/94.png",
            spriteBack: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/back/94.png",
            spriteShiny: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/shiny/94.png",
            dreamWorld: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/dream-world/94.svg",
            officialArtwork: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/94.png",
            showdown: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/showdown/94.gif",
            home: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/home/94.png",
            evolutionChain: ["Gastly", "Haunter", "Gengar"]
        )

        let onixSpecies = PokemonSpecies(
            id: 95,
            name: "Onix",
            types: ["Rock", "Ground"],
            spriteFront: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/95.png",
            spriteBack: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/back/95.png",
            spriteShiny: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/shiny/95.png",
            dreamWorld: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/dream-world/95.svg",
            officialArtwork: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/95.png",
            showdown: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/showdown/95.gif",
            home: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/home/95.png",
            evolutionChain: ["Onix", "Steelix"]
        )

        let alakazamSpecies = PokemonSpecies(
            id: 65,
            name: "Alakazam",
            types: ["Psychic"],
            spriteFront: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/65.png",
            spriteBack: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/back/65.png",
            spriteShiny: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/shiny/65.png",
            dreamWorld: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/dream-world/65.svg",
            officialArtwork: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/65.png",
            showdown: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/showdown/65.gif",
            home: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/home/65.png",
            evolutionChain: ["Abra", "Kadabra", "Alakazam"]
        )

        let dragoniteSpecies = PokemonSpecies(
            id: 149,
            name: "Dragonite",
            types: ["Dragon", "Flying"],
            spriteFront: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/149.png",
            spriteBack: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/back/149.png",
            spriteShiny: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/shiny/149.png",
            dreamWorld: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/dream-world/149.svg",
            officialArtwork: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/149.png",
            showdown: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/showdown/149.gif",
            home: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/home/149.png",
            evolutionChain: ["Dratini", "Dragonair", "Dragonite"]
        )

        // Create Pokémon instances with species
        let pikachu = Pokemon(id: UUID(), species: pikachuSpecies, xp: 120)
        let charmander = Pokemon(id: UUID(), species: charmanderSpecies, xp: 200)
        let squirtle = Pokemon(id: UUID(), species: squirtleSpecies, xp: 150)
        let bulbasaur = Pokemon(id: UUID(), species: bulbasaurSpecies, xp: 50)
        let gengar = Pokemon(id: UUID(), species: gengarSpecies, xp: 180)
        let onix = Pokemon(id: UUID(), species: onixSpecies, xp: 220)
        let alakazam = Pokemon(id: UUID(), species: alakazamSpecies, xp: 190)
        let dragonite = Pokemon(id: UUID(), species: dragoniteSpecies, xp: 300)

        // Add Pokémon to the manager
        manager.pokemons = [pikachu, charmander, squirtle, bulbasaur, gengar, onix, alakazam, dragonite]
        manager.currentPokemonID = pikachu.id // Set Pikachu as default
        return manager
    }()

    // Session Manager with mock sessions
    static let sessionManager: SessionManager = {
        let manager = SessionManager()
        let session1 = Session(duration: 25 * 60, startTime: Date().addingTimeInterval(-3600), endTime: Date().addingTimeInterval(-3300), completed: true, pokemonID: pokemonManager.pokemons[0].id)
        let session2 = Session(duration: 15 * 60, startTime: Date().addingTimeInterval(-1800), endTime: Date().addingTimeInterval(-900), completed: false, pokemonID: pokemonManager.pokemons[0].id)
        let session3 = Session(duration: 30 * 60, startTime: Date().addingTimeInterval(-7200), endTime: Date().addingTimeInterval(-6900), completed: true, pokemonID: pokemonManager.pokemons[0].id)

        manager.restoreSessions(from: [session1, session2, session3])
        return manager
    }()
}
