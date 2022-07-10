//
//  PokemonSelected.swift
//  PokedexApp
//
//  Created by Mert Şafaktepe on 10.07.2022.
//

import Foundation

struct PokemonSelected: Codable {
    var sprites: PokemonSprites
    var weight: Int
    var height: Int
}

struct PokemonSprites: Codable {
    var front_default: String
}
