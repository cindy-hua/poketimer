//
//  PokemonListViewModel.swift
//  PokeTimer
//
//  Created by HUA Cindy on 26/02/2025.
//

import Foundation

@Observable
class PokemonListViewModel {
    private let pokemonManager: PokemonManager

    var ownedPokemon: [Pokemon] {
        pokemonManager.pokemons
    }

    var pokemonDetails: [UUID: PokemonSpecies] = [:]

    init(pokemonManager: PokemonManager) {
        self.pokemonManager = pokemonManager
        Task { await fetchOwnedPokemonDetails() }
    }

    /// Fetches API data only for Pokémon the user owns
    func fetchOwnedPokemonDetails() async {
        for pokemon in ownedPokemon {
            do {
                let details = try await PokemonAPI.shared.fetchCompletePokemonData(name: pokemon.species.name)
                await MainActor.run {
                    self.pokemonDetails[pokemon.id] = details
                }
            } catch {
                print("❌ [ERROR] Failed to fetch details for \(pokemon.species): \(error)")
            }
        }
    }

    /// Adds a new Pokémon to the list.
    func addPokemon(species: PokemonSpecies) {
        let newPokemon = Pokemon(species: species)
        pokemonManager.addPokemon(newPokemon)
        print("➕ [DEBUG] Added Pokémon: \(newPokemon.species)")

        // Fetch its API details immediately
        Task {
            do {
                let details = try await PokemonAPI.shared.fetchCompletePokemonData(name: species.name)
                await MainActor.run {
                    self.pokemonDetails[newPokemon.id] = details
                }
            } catch {
                print("❌ [ERROR] Failed to fetch details for \(species): \(error)")
            }
        }
    }
}
