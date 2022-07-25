//
//  TypeColors.swift
//  PokedexApp
//
//  Created by Mert Şafaktepe on 24.07.2022.
//

import Foundation
import UIKit


class TypeColors {
    
  
    
//          "flying"
//          "poison"
//          "ground"
//          "rock"
//          "bug"
//          "ghost"
//          "steel"
//          "fire"
//          "water"
//          "grass"
//          "electric"
//          "psychic"
//          "ice"
//          "dragon"
//          "fairy"
//          "dark"
//
//
    
}

extension TypeColors {
      func fetchColor(colorName: String) -> UIColor {
          switch colorName {
          case "flying" :
          return UIColor(named: "flying") ?? UIColor()
          case "poison" :
          return UIColor(named: "poison") ?? UIColor()
          case "ground" :
          return UIColor(named: "ground") ?? UIColor()
          case "rock" :
          return UIColor(named: "rock") ?? UIColor()
          case "bug" :
          return UIColor(named: "bug") ?? UIColor()
          case "ghost" :
          return UIColor(named: "bug") ?? UIColor()
          case "steel" :
          return UIColor(named: "steel") ?? UIColor()
          case "fire" :
          return UIColor(named: "fire") ?? UIColor()
          case "water" :
          return UIColor(named: "water") ?? UIColor()
          case "grass" :
          return UIColor(named: "grass") ?? UIColor()
          case "electric" :
          return UIColor(named: "electric") ?? UIColor()
          case "psychic" :
          return UIColor(named: "psychic") ?? UIColor()
          case "ice" :
          return UIColor(named: "ice") ?? UIColor()
          case "fairy" :
          return UIColor(named: "fairy") ?? UIColor()
          case "dragon" :
          return UIColor(named: "dragon") ?? UIColor()
          case "dark" :
          return UIColor(named: "dark") ?? UIColor()
          default:
          return UIColor(named: "gray") ?? UIColor()
          }
          
          
          
      }
      
}
