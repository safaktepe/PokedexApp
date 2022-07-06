//
//  CardView.swift
//  PokedexApp
//
//  Created by Mert Şafaktepe on 6.07.2022.
//

import UIKit


class CardView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        initialSetup()
        
    }
    
    private func  initialSetup() {
        layer.cornerRadius = 10
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = .zero
        layer.shadowOpacity = 0.1
    }

}

