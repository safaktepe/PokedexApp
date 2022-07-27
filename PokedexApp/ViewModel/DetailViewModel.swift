//
//  DetailViewModel.swift
//  PokedexApp
//
//  Created by Mert Şafaktepe on 10.07.2022.
//

import Foundation

class DetailViewModel {
    var str             = ""
    var chosenPokemon   : DetailPokemon?
    var pokeId          : Int?
    
    private let pokemonManager          = PokemonManager()
    var pokemonList                     = [Pokemon]()
    var pokemonDetails                  : DetailPokemon?
    var onComplete                      : ( () -> Void )?
    
    
    func setChosenPokemon() {
        guard let pokeId = pokeId else {
            return
        }
        pokemonManager.getDetailedPokemon(id: pokeId, { [weak self] pokemon in
        self?.chosenPokemon = pokemon
            self?.onComplete?()
        })
    }
    
    func convertStringFromOptInt(value: Int?) -> String{
        let stringValue: String = "\(value ?? 0)"
        return stringValue
    }
        
    
    func formatFloat(value: Int) -> Float {
        let formatedValue: Float = (Float(value) * 1.0) / 120
        return formatedValue
    }
    
    
    func getPokemonIndex (pokemon: Pokemon) -> Int {
        if let index =  self.pokemonList.firstIndex(of: pokemon) {
            return index + 1
        }
        return 0
    }
    
    
    func getDetailsWithId(id: Int) {
        pokemonManager.getDetailedPokemon(id: id) { data in
            DispatchQueue.main.async {
                self.pokemonDetails = data
            }
      }
   }
    
    func setImage() -> String {
        var imageUrl   = "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/\(pokeId!).png" //  staticBaseUrl
        return imageUrl
    }
    
    
}

