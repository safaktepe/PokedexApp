//
//  PokemonManager.swift
//  pokk
//
//  Created by Mert Şafaktepe on 12.07.2022.
//

import Foundation

class PokemonManager {
    

    func getPokemon()  -> [Pokemon] {
        let data: PokemonPage =  NetworkService().decode(url: "https://pokeapi.co/api/v2/pokemon?limit=1000&offset=0")
        let pokemon: [Pokemon] = data.results
        return pokemon
    }
    
    func getDetailedPokemon(id: Int, _ completion: @escaping (DetailPokemon) -> () ) {
        NetworkService().fetchData(url: "https://pokeapi.co/api/v2/pokemon/\(id)", model: DetailPokemon.self) { data in
            completion(data)
        } failure: { error in
            print(error.localizedDescription)
        }

    }
}
//https://pokeapi.co/api/v2/pokemon?limit151
