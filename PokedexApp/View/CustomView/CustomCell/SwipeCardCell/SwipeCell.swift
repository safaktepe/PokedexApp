//
//  SwipeCell.swift
//  PokedexApp
//
//  Created by Mert Şafaktepe on 10.08.2022.
//

import UIKit
import VerticalCardSwiper

class SwipeCell: CardCell {

    @IBOutlet weak var swBackgroundView: UIView!
    @IBOutlet weak var swCardImage: UIImageView!
    @IBOutlet weak var swTitleLabel: UILabel!
    @IBOutlet weak var swIdLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        swBackgroundView.layer.cornerRadius = 10
        
    }

}
