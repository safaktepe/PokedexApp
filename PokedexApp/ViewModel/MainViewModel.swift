//
//  MainViewModel.swift
//  PokedexApp
//
//  Created by Mert Şafaktepe on 10.07.2022.
//

import Foundation

class MainViewModel {

     private let pokemonManager          = PokemonManager()
     var pokemonList                     = [Pokemon]()
     var pokemonDetails                  : DetailPokemon?
    
     init() {
     self.pokemonList                    = pokemonManager.getPokemon()
     }
    
    func getPokemonIndex (pokemon: Pokemon) -> Int {
        if let index =  self.pokemonList.firstIndex(of: pokemon) {
            return index + 1
        }
        return 0
    }
        
    func getDetails(pokemon: Pokemon) {
        let id = getPokemonIndex(pokemon: pokemon)
        pokemonManager.getDetailedPokemon(id: id) { data in
            DispatchQueue.main.async {
                self.pokemonDetails = data
            }
      }
   }
    
    func getDetailsWithId(id: Int) {
        pokemonManager.getDetailedPokemon(id: id) { data in
            DispatchQueue.main.async {
                self.pokemonDetails = data
            }
      }
   }
    
    func formatHeighWeight(value : Int) -> String {
        let dValue               = Double(value)
        let string               = String(format: "%.2f", dValue / 10)
        
        return string
    }
    
}

