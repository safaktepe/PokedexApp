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
        
        swBackgroundView.layer.cornerRadius   = 40
        swIdLabel?.layer.masksToBounds        = true
        swIdLabel?.layer.cornerRadius         = 16


//        swBackgroundView.layer.shadowColor    = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
//        swBackgroundView.layer.shadowOpacity  = 1.0
//        swBackgroundView.layer.shadowRadius   = 2.0
//        swBackgroundView.layer.masksToBounds  = false
//        swBackgroundView.layer.cornerRadius   = 4.0
    }

}
