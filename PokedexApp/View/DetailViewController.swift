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
    let viewModel       = DetailViewModel()
    
    //MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBarController?.tabBar.isHidden = true
        configure()
        viewModel.onComplete =  { [weak self] in
            self?.setupDeteailPage()
            }
        viewModel.setChosenPokemon()
    }
        
    //MARK: - Presentation
        
        func setupDeteailPage() {
        
        self.pokeNameLabel?.text             = self.viewModel.chosenPokemon?.name
        self.idLabel.text                    = self.viewModel.convertStringFromOptInt(value: self.viewModel.chosenPokemon?.id)
        self.weightLabel?.text               = self.viewModel.convertStringFromOptInt(value: self.viewModel.chosenPokemon?.weight)
        self.heightLabel?.text               = self.viewModel.convertStringFromOptInt(value: self.viewModel.chosenPokemon?.height)
        var imageUrl                         = self.viewModel.setImage()
        self.imageView.kf.setImage(with: URL(string: imageUrl))
        self.setTypes(typeElements: self.viewModel.chosenPokemon?.types)
        self.setProgressAnimates()
        var backgroundColor: String          = self.viewModel.chosenPokemon?.types[0].type.name ?? ""
        self.backgroundView.backgroundColor  = UIColor(named: backgroundColor)
    }
    //MARK: - Functions
    func animateStatBars(value: Float, bar: UIProgressView) {
        bar.setProgress(value, animated: true)
    }
    
    func setProgressAnimates() {
        let hp        : Int = viewModel.chosenPokemon?.stats[0].base_stat ?? 0
        let atk       : Int = viewModel.chosenPokemon?.stats[1].base_stat ?? 0
        let def       : Int = viewModel.chosenPokemon?.stats[2].base_stat ?? 0
        let spdef     : Int = viewModel.chosenPokemon?.stats[4].base_stat ?? 0
        let speed     : Int = viewModel.chosenPokemon?.stats[5].base_stat ?? 0
                
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
    
    func convertStringFromOptInt(value: Int?) -> String{
        var stringValue: String = "\(value ?? 0)"
        return stringValue
    }
    
    
    func setTypes( typeElements: [TypeElement]? ) {
        firstTitleLabel?.text                  = typeElements?[0].type.name
        var backgroundColorFirst: String       = viewModel.chosenPokemon?.types[0].type.name ?? ""
        [firstTitleLabel?.backgroundColor: [UIColor (named: backgroundColorFirst)]]
        if typeElements?.count == 1 {
            secondTitleLabel?.isHidden = true
        }
        else {
            secondTitleLabel?.isHidden             = false
            secondTitleLabel?.text                 = typeElements?[1].type.name
            var backgroundColorSecond: String      = viewModel.chosenPokemon?.types[1].type.name ?? ""
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
