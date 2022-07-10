//
//  PokeCell.swift
//  PokedexApp
//
//  Created by Mert Şafaktepe on 5.07.2022.
//

import UIKit

class PokeCell: UICollectionViewCell {

    //MARK: - Outlets
    @IBOutlet weak var cellContainerview: UIView!
    @IBOutlet weak var cellNameLabel: UILabel!
    @IBOutlet weak var cellImageView: UIImageView!
    @IBOutlet weak var cellContainerView: CardView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setup(with pokemon: PokemonEntry) {
        cellImageView.image = UIImage(named: "blindspot")
        cellNameLabel.text = pokemon.name
    }

}
