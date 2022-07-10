//
//  Webservice.swift
//  PokedexApp
//
//  Created by Mert Şafaktepe on 7.07.2022.
//

import Foundation

struct Webservice {
    
    // A function that get data from API - Only names and URLs of Pokemons.
  func getData(completion: @escaping (Pokemon?, Error?) -> () ) {
        guard let url = URL(string: "https://pokeapi.co/api/v2/pokemon?limit151") else {return}
        URLSession.shared.dataTask(with: url) { data, res, err in
        if let err = err {
        completion(nil, err)
        return
        }
        do {
        let pokemons = try JSONDecoder().decode(Pokemon.self, from: data!)
        completion(pokemons, nil)
    //  pokemons.results.forEach({print($0.name)})
        } catch {
        completion(nil, error)
        print(error.localizedDescription)
        }
        }.resume()
}
    
    
    
    // A function that interacts with API to get detail data with url which came from getData function.
    func getSelectedPokemonData(url: String, completion: @escaping (PokemonSelected?, Error?) -> () ) {
        guard let url = URL(string: url) else {return}
        URLSession.shared.dataTask(with: url) { detailData, res, err in
        if let err = err {
        print(err.localizedDescription)
        return
        }
        do {
        let pokemonDetailed = try JSONDecoder().decode(PokemonSelected.self, from: detailData!)
        completion(pokemonDetailed, nil)
     // pokemons.results.forEach({print($0.name)})
        } catch {
        print(error.localizedDescription)
                }
        }.resume()
                }
}
