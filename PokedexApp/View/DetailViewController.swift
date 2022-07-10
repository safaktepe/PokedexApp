//
//  DetailViewController.swift
//  PokedexApp
//
//  Created by Mert Şafaktepe on 5.07.2022.
//

import UIKit

class DetailViewController: UIViewController {
    
    //MARK: - Outlets
    @IBOutlet weak var pokeImageView: UIImageView?
    @IBOutlet weak var pokeNameLabel: UILabel?
    @IBOutlet weak var secondTitleLabel: UILabel?
    @IBOutlet weak var firstTitleLabel: UILabel?
    @IBOutlet weak var heightLabel: UILabel?
    @IBOutlet weak var weightLabel: UILabel?
    @IBOutlet weak var hpLabel: UILabel?
    @IBOutlet weak var expLabel: UILabel?
    @IBOutlet weak var atkLabel: UILabel?
    @IBOutlet weak var spdLabel: UILabel?
    @IBOutlet weak var defLabel: UILabel?
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        
        
    }
    
    func setupLabelRadius() {
        firstTitleLabel?.layer.cornerRadius = 16
        firstTitleLabel?.layer.masksToBounds = true
        secondTitleLabel?.layer.cornerRadius = 16
        secondTitleLabel?.layer.masksToBounds = true
    }
    
    func configure() {
        setupLabelRadius()
    }
}
