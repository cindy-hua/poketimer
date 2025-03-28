//
//  PokeTimerTests.swift
//  PokeTimerTests
//
//  Created by HUA Cindy on 28/03/2025.
//

import XCTest
@testable import PokeTimer

final class PokeTimerTests: XCTestCase {
    
    // MARK: - Pokemon Tests
    
    func testPokemonGainingXP() {
        let species = dummySpecies(id: 25, name: "pikachu")
        let original = Pokemon(species: species, xp: 10)
        let updated = original.gainingXP(5)
        XCTAssertEqual(updated.xp, 15)
    }
    
    // MARK: - Session Tests
    
    func testSessionDurationInMinutes() {
        let session = Session(
            duration: 1500, // 25 minutes
            startTime: Date(),
            endTime: Date().addingTimeInterval(1500),
            completed: true,
            pokemonID: UUID()
        )
        XCTAssertEqual(session.durationInMinutes, 25)
    }
    
    // MARK: - PokemonManager Tests
    
    func testSelectNextPokemon() {
        let bulbasaur = Pokemon(species: dummySpecies(id: 1, name: "bulbasaur"))
        let charmander = Pokemon(species: dummySpecies(id: 4, name: "charmander"))
        let manager = PokemonManager(pokemons: [bulbasaur, charmander], currentPokemonID: bulbasaur.id)
        
        manager.selectNextPokemon()
        XCTAssertEqual(manager.currentPokemonID, charmander.id)
    }
    
    func testSelectPreviousPokemon() {
        let bulbasaur = Pokemon(species: dummySpecies(id: 1, name: "bulbasaur"))
        let charmander = Pokemon(species: dummySpecies(id: 4, name: "charmander"))
        let manager = PokemonManager(pokemons: [bulbasaur, charmander], currentPokemonID: charmander.id)
        
        manager.selectPreviousPokemon()
        XCTAssertEqual(manager.currentPokemonID, bulbasaur.id)
    }
    
    func testSaveAndLoadPokemonManager() {
        let species = dummySpecies(id: 1, name: "testmon")
        let pokemon = Pokemon(species: species, xp: 42)
        let manager = PokemonManager(pokemons: [pokemon], currentPokemonID: pokemon.id)

        let tempDir = FileManager.default.temporaryDirectory
        let persistence = PersistenceManager(
            pokemonFileURL: tempDir.appendingPathComponent("test_pokemon.json"),
            sessionFileURL: tempDir.appendingPathComponent("test_session.json")
        )

        persistence.savePokemonManager(manager)
        let loaded = persistence.loadPokemonManager()

        XCTAssertEqual(loaded.pokemons, manager.pokemons)
        XCTAssertEqual(loaded.currentPokemonID, manager.currentPokemonID)
    }

    // MARK: - Helpers

    func dummySpecies(id: Int, name: String) -> PokemonSpecies {
        return PokemonSpecies(
            id: id,
            name: name,
            types: ["normal"],
            spriteFront: "",
            spriteBack: nil,
            spriteShiny: nil,
            dreamWorld: nil,
            officialArtwork: nil,
            showdown: nil,
            home: nil,
            evolutionChain: []
        )
    }
}
