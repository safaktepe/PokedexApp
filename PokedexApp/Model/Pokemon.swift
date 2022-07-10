//
//  Pokemon.swift
//  PokedexApp
//
//  Created by Mert Şafaktepe on 7.07.2022.
//

import UIKit

struct Pokemon: Codable {
    var results: [PokemonEntry]
}

struct PokemonEntry: Codable {
//    var id = UUID() Identifiable
    var name: String
    var url: String
}
