//
//  DetailViewController.swift
//  PokedexApp
//
//  Created by Mert Şafaktepe on 5.07.2022.
//

import UIKit
import Kingfisher

class DetailViewController: UIViewController {
    
    //MARK: - Outlets
    @IBOutlet weak var pokeNameLabel        : UILabel?
    @IBOutlet weak var secondTitleLabel     : UILabel?
    @IBOutlet weak var firstTitleLabel      : UILabel?
    @IBOutlet weak var heightLabel          : UILabel?
    @IBOutlet weak var weightLabel          : UILabel?
    @IBOutlet weak var expLabel             : UILabel?
    @IBOutlet weak var hiddenLabel          : UILabel!
    @IBOutlet weak var hiddenProgress       : UILabel!
    @IBOutlet weak var backgroundView       : UIView!
    @IBOutlet weak var idLabel              : UILabel!
    @IBOutlet weak var hpProgressBar        : UIProgressView!
    @IBOutlet weak var atkProgressBar       : UIProgressView!
    @IBOutlet weak var defProgressBar       : UIProgressView!
    @IBOutlet weak var spdProgressBar       : UIProgressView!
    @IBOutlet weak var expProgressBar       : UIProgressView!
    @IBOutlet weak var imageView            : UIImageView!
    
    var str             = ""
    var manager         = PokemonManager()
    var chosenPokemon   : DetailPokemon?
    var pokeId          : Int?

    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()

        // MARK: - Service
        if let pokeId = pokeId {
            manager.getDetailedPokemon(id: pokeId, { pokemon in
            self.chosenPokemon = pokemon
        }) } else { print("Ooops") }
        
        //MARK: - Presentation
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            self.pokeNameLabel?.text          = self.chosenPokemon?.name
            self.idLabel.text                 = "\(self.chosenPokemon?.id ?? 0)"
            self.weightLabel?.text            = "\(self.chosenPokemon?.weight ?? 0)"
            self.heightLabel?.text            = "\(self.chosenPokemon?.height ?? 0)"
            var id: Int                       = self.chosenPokemon?.id  ?? 1
            var imageUrl                      = "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/\(id).png"
            self.imageView.kf.setImage(with: URL(string: imageUrl))
            self.setTypes(typeElements: self.chosenPokemon?.types)
            self.setProgressAnimates()
            var backgroundColor: String       = self.chosenPokemon?.types[0].type.name ?? ""
            print(backgroundColor)
            self.backgroundView.backgroundColor    = UIColor(named: backgroundColor)
        }

    }
    
    //MARK: - Functions
    func animateStatBars(value: Float, bar: UIProgressView) {
        bar.setProgress(value, animated: true)
    }
    
    func setProgressAnimates() {
        var hp        : Int = chosenPokemon?.stats[0].base_stat ?? 0
        var atk       : Int = chosenPokemon?.stats[1].base_stat ?? 0
        var def       : Int = chosenPokemon?.stats[2].base_stat ?? 0
        var spdef     : Int = chosenPokemon?.stats[4].base_stat ?? 0
        var speed     : Int = chosenPokemon?.stats[5].base_stat ?? 0
                
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.45) {
        self.animateStatBars(value: self.formatFloat(value: hp),    bar: self.hpProgressBar)
        self.animateStatBars(value: self.formatFloat(value: atk),   bar: self.atkProgressBar)
        self.animateStatBars(value: self.formatFloat(value: def),   bar: self.defProgressBar)
        self.animateStatBars(value: self.formatFloat(value: spdef), bar: self.expProgressBar)
        self.animateStatBars(value: self.formatFloat(value: speed), bar: self.spdProgressBar)
        }
        
        
    }
    
    func formatFloat(value: Int) -> Float {
        var formatedValue: Float = (Float(value) * 1.0) / 120
        return formatedValue
    }
    
    func setTypes( typeElements: [TypeElement]? ) {
        firstTitleLabel?.text                  = typeElements?[0].type.name
        var backgroundColorFirst: String       = chosenPokemon?.types[0].type.name ?? ""
        [firstTitleLabel?.backgroundColor: [UIColor (named: backgroundColorFirst)]]
        if typeElements?.count == 1 {
            secondTitleLabel?.isHidden = true
        }
        else {
            secondTitleLabel?.isHidden             = false
            secondTitleLabel?.text                 = typeElements?[1].type.name
            var backgroundColorSecond: String      = chosenPokemon?.types[1].type.name ?? ""
            [secondTitleLabel?.backgroundColor:[UIColor (named: backgroundColorSecond)]]
        }
    }
    
    //MARK: - Component Configration
    
    func setupLabelRadius() {
        firstTitleLabel?.layer.cornerRadius      = 16
        firstTitleLabel?.layer.masksToBounds     = true
        secondTitleLabel?.layer.cornerRadius     = 16
        secondTitleLabel?.layer.masksToBounds    = true
        
    }
    
    func configure() {
        setupLabelRadius()
        hiddenLabel.isHidden        = true
        hiddenProgress.isHidden     = true
        
        //Bottom rounded corners for backgroundView
        backgroundView.clipsToBounds        = true
        backgroundView.layer.cornerRadius   = 40
        backgroundView.layer.maskedCorners  = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]

        //Configure progress bars
        
        hpProgressBar.transform  = hpProgressBar.transform.scaledBy(x: 1, y: 0.5)
        atkProgressBar.transform = atkProgressBar.transform.scaledBy(x: 1, y: 0.5)
        defProgressBar.transform = defProgressBar.transform.scaledBy(x: 1, y: 0.5)
        spdProgressBar.transform = spdProgressBar.transform.scaledBy(x: 1, y: 0.5)
        expProgressBar.transform = expProgressBar.transform.scaledBy(x: 1, y: 0.5)


        
    }
    
    
    
    
}
